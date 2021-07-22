import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:fort_macarthur/Game/models/enemyplane.dart';

import 'game_object.dart';

// class that handles the missile bounding box that is moving towards
// it's destination
class Missile extends GameObjectCollRect with Hitbox, Collidable {
  Vector2 missileDirection = Vector2.zero();
  double missileSpeed;
  bool touchedPlane = false;
  Color missileColor;

  Missile(
      {required Vector2 size,
      required this.missileColor,
      required Vector2 position,
      double angle = 0.0,
      this.missileSpeed = 300.0})
      : super(
          size: size,
          color: missileColor,
          position: position,
          angle: angle,
        ) {
    collider.size = size;
    collider.position = position;
    collider.angle = angle;

    addShape(collider);

    collider.component.size = size;
    collider.component.position = position;
    collider.component.angle = angle;
  }

  void setPosition(Vector2 position) {
    super.setPosition(position - (size / 2.0));
    collider.position = position - (size / 2.0);
    collider.component.position = position - (size / 2.0);
  }

  Vector2 get position {
    return super.position;
  }

  // moves the missile in it's direction
  void update(double dt) {
    super.update(dt);
    super.position.add(missileDirection * missileSpeed * dt);
    collider.position = super.position;
    collider.component.position = super.position;
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
  }
}
