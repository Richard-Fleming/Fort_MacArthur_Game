import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:fort_macarthur/game/models/trail_particles.dart';
import 'package:fort_macarthur/game/utilities/random_range.dart';

class ExplosionParticleSystem {
  Vector2 directionRange;
  Vector2 spawnPosition;
  List<CustomParticle> particles = [];

  Color? color;

  double speed;
  double acceleration;
  double radius;
  double timeToLive;

  int fadeOutRate;
  int numOfParticles;

  ExplosionParticleSystem({
    required this.directionRange,
    required this.spawnPosition,
    this.color,
    this.speed = 1.0,
    this.acceleration = 0.0,
    this.radius = 10.0,
    this.fadeOutRate = 1,
    this.timeToLive = 0.0,
    this.numOfParticles = 100,
  }) {
    bool randomColors = false;

    for (var i = 0; i < numOfParticles; ++i) {
      Vector2 direction = Vector2(
        doubleInRange(directionRange.x, directionRange.y),
        doubleInRange(directionRange.x, directionRange.y),
      );

      if (color == null || randomColors) {
        color = Color.fromARGB(
          255,
          intInRange(1, 255),
          intInRange(1, 255),
          intInRange(1, 255),
        );
        randomColors = true;
      }

      particles.add(new CustomParticle(
        color: color!,
        speed: direction * speed,
        acceleration: direction * acceleration,
        position: spawnPosition,
        radius: radius,
        fadeOutRate: fadeOutRate,
        timeToLive: timeToLive,
      ));
    }
  }

  void update(double dt) {
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
