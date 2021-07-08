import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class TrailParticle extends AcceleratedParticle {
  Vector2? parentDirection;
  double radius;
  Color color;
  int fadeOutRate;
  late Timer timer;
  int alpha = 0;

  TrailParticle({
    Vector2? position,
    Vector2? speed,
    Vector2? acceleration,
    this.radius = 10.0,
    double timeToLive = 5.0,
    this.fadeOutRate = 1,
    required this.color,
    this.parentDirection,
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

  bool fadedOut() {
    if (timeOut()) {
      alpha -= fadeOutRate;
      if (alpha < 0) return true;
      print("alpha; " + alpha.toString());

      this.color = Color.fromARGB(
          alpha, this.color.red, this.color.green, this.color.blue);
      print("alpha latre: " + this.color.alpha.toString());
      super.child =
          CircleParticle(paint: Paint()..color = this.color, radius: radius);
    }
    return false;
  }

  void update(double dt) {
    if (!fadedOut()) {
      super.update(dt);
      timer.update(dt);
    }
  }

  void render(Canvas canvas) {
    if (!fadedOut()) {
      super.render(canvas);
    }
  }
}
