import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/game.dart';
import 'package:fort_macarthur/Game/models/enemyplane.dart';

import 'game_object.dart';

// class that handles the missile bounding box that is moving towards
// it's destination
class Missile extends GameObjectRect with Hitbox, Collidable {
  Vector2 missileDirection = Vector2.zero();
  double missileSpeed;
  HitboxShape hitbox = HitboxRectangle(relation: Vector2(1.0, 1.0));
  bool touchedPlane = false;

  Missile(
      {required Vector2 size,
      required Color color,
      required Vector2 position,
      double angle = 0.0,
      this.missileSpeed = 300.0})
      : super(
          size: size,
          color: color,
          position: position,
          angle: angle,
        ) {
    addShape(hitbox);
    hitbox.component.size = size;
    hitbox.component.position = position;
    hitbox.component.angle = angle;
  }

  void setPosition(Vector2 position) {
    super.setPosition(position - (size / 2.0));
    hitbox.component.position = position - (size / 2.0);
  }

  Vector2 get position {
    return super.position;
  }

  // moves the missile in it's direction
  void update(double dt) {
    super.update(dt);
    super.position.add(missileDirection * missileSpeed * dt);
    hitbox.component.position = Vector2(
        hitbox.component.position.x + (missileDirection.x * missileSpeed) * dt,
        hitbox.component.position.y + (missileDirection.y * missileSpeed) * dt);
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
    super.render(canvas);
    hitbox.render(canvas, Paint()..color = Colors.white);
  }
}
