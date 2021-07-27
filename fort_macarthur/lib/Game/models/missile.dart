import 'dart:math';

import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:fort_macarthur/Game/models/enemyplane.dart';
import 'package:fort_macarthur/game/models/trail_particles.dart';

// class that handles the missile bounding box that is moving towards
// it's destination
class Missile extends PositionComponent with Hitbox, Collidable {
  HitboxShape collider = HitboxRectangle();
  Vector2 missileDirection = Vector2.zero();
  double missileSpeed;
  bool touchedPlane = false;
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
          position: position,
          angle: angle,
        ) {
    collider.size = size;
    collider.offsetPosition = position;
    collider.angle = angle;

    addShape(collider);

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
    collider.offsetPosition = position - (size / 2.0);
    particles.updatePosition(collider.position);
    // collider.component.position = position - (size / 2.0);
  }

  Vector2 get position {
    return collider.offsetPosition;
  }

  // calculates angle to face the direction passed.
  // far from perfect
  void faceDirection(Vector2 direction) {
    collider.angle = atan2(direction.y, direction.x);
  }

  void clearParticles() {
    particles.particles.clear();
  }

  // moves the missile in it's direction
  void update(double dt) {
    super.update(dt);
    collider.offsetPosition.add(missileDirection * missileSpeed * dt);
    particles.updatePosition(collider.position);
    particles.updateDirection(missileDirection);
    particles.update(dt);
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is EnemyPlane) {
      touchedPlane = true;
      print("plane was touched :))");
    }
  }

  // draws the missile
  void render(Canvas canvas) {
    particles.render(canvas);
    collider.render(canvas, Paint()..color = Colors.white);
    super.render(canvas);
  }
}
