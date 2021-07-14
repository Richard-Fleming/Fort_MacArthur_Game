import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class TrailParticleSystem {
  Vector2 parentDirection;
  Vector2 position;
  List<TrailParticle> particles = [];
  late Timer spawnTimer;

  Color color;

  double spawnRate;
  double speed;
  double acceleration;
  double radius;

  TrailParticleSystem({
    required this.parentDirection,
    required this.position,
    required this.color,
    this.spawnRate = 1.0,
    this.speed = 1.0,
    this.acceleration = 0.0,
    this.radius = 10.0,
  }) {
    spawnTimer = new Timer(spawnRate);
    spawnTimer.start();
    particles.add(new TrailParticle(
      color: color,
      speed: -parentDirection * speed,
      acceleration: -parentDirection * acceleration,
      position: position,
      radius: radius,
    ));
    // spawnTimer.repeat = true;
  }

  void update(double dt) {
    spawnTimer.update(dt);
    if (spawnTimer.finished) {
      particles.add(new TrailParticle(
        color: color,
        speed: -parentDirection * speed,
        acceleration: -parentDirection * acceleration,
        position: position,
        radius: radius,
      ));

      spawnTimer = new Timer(spawnRate);
      spawnTimer.start();
    }

    for (int i = particles.length - 1; i >= 0; --i) {
      particles.elementAt(i).update(dt);

      if (particles.elementAt(i).hasFadedOut()) {
        particles.removeAt(i);
      }
    }
  }

  void render(Canvas canvas) {
    for (int i = particles.length - 1; i >= 0; --i) {
      particles.elementAt(i).render(canvas);
    }
  }
}

class TrailParticle extends AcceleratedParticle {
  double radius;
  Color color;
  int fadeOutRate;
  late Timer timer;
  int alpha = 0;

  bool fadedOut = false;

  TrailParticle({
    Vector2? position,
    Vector2? speed,
    Vector2? acceleration,
    this.radius = 10.0,
    double timeToLive = 0.0,
    this.fadeOutRate = 1,
    required this.color,
  }) : super(
          acceleration: acceleration,
          speed: speed,
          position: position,
          child: CircleParticle(paint: Paint()..color = color, radius: radius),
        ) {
    alpha = this.color.alpha;
    timer = new Timer(timeToLive);
    timer.start();
  }

  bool timeOut() {
    return timer.finished;
  }

  bool hasFadedOut() {
    return fadedOut;
  }

  void fadeOut() {
    if (timeOut()) {
      alpha -= fadeOutRate;
      if (alpha < 0) {
        fadedOut = true;
        return;
      }
      // print("alpha; " + alpha.toString());

      this.color = Color.fromARGB(
          alpha, this.color.red, this.color.green, this.color.blue);
      // print("alpha latre: " + this.color.alpha.toString());
      super.child =
          CircleParticle(paint: Paint()..color = this.color, radius: radius);
    }
    fadedOut = false;
  }

  void update(double dt) {
    if (!hasFadedOut()) {
      fadeOut();
      super.update(dt);
      timer.update(dt);
    }
  }

  void render(Canvas canvas) {
    if (!hasFadedOut()) {
      super.render(canvas);
    }
  }
}
