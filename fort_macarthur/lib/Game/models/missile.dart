import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:fort_macarthur/Game/models/enemyplane.dart';
import 'package:fort_macarthur/game/models/trail_particles.dart';

import 'game_object.dart';

// class that handles the missile bounding box that is moving towards
// it's destination
class Missile extends GameObjectCollRect with Hitbox, Collidable {
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
          color: color,
          position: position,
          angle: angle,
        ) {
    collider.size = size;
    collider.offsetPosition = position;
    collider.angle = angle;

    addShape(collider);

    collider.component.size = size;
    collider.component.position = position;
    collider.component.angle = angle;

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
    super.setPosition(position - (size / 2.0));
    collider.offsetPosition = position - (size / 2.0);
    // collider.component.position = position - (size / 2.0);
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
    collider.offsetPosition = super.position;
    collider.offsetPosition = super.position;
    particles.updatePosition(position + getCenter());
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
    super.render(canvas);
  }
}
