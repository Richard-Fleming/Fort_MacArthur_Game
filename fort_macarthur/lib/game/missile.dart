import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:fort_macarthur/game/trail_particles.dart';

import 'game_object.dart';

// class that handles the missile bounding box that is moving towards
// it's destination
class Missile extends GameObjectRect {
  Vector2 missileDirection = Vector2.zero();
  double missileSpeed;
  late TrailParticleSystem particles;

  Missile(
      {required Vector2 size,
      required Color color,
      required Vector2 position,
      double angle = 0.0,
      Color particleColor = Colors.white,
      this.missileSpeed = 300.0})
      : super(
          size: size,
          color: color,
          position: position,
          angle: angle,
        ) {
    particles = new TrailParticleSystem(
      parentDirection: -missileDirection,
      spawnPosition: position,
      color: particleColor,
      speed: 40,
      spawnRate: 0.005,
      fadeOutRate: 8,
      acceleration: 5,
      radius: 5,
    );
  }

  void setPosition(Vector2 position) {
    super.setPosition(position);
  }

  Vector2 get position {
    return super.position;
  }

  void clearParticles() {
    particles.particles.clear();
  }

  // moves the missile in it's direction
  void update(double dt) {
    super.update(dt);
    super.position.add(missileDirection * missileSpeed * dt);
    particles.updatePosition(position);
    particles.updateDirection(missileDirection);
    particles.update(dt);
  }

  // draws the missile
  void render(Canvas canvas) {
    super.render(canvas);
    particles.render(canvas);
  }
}
