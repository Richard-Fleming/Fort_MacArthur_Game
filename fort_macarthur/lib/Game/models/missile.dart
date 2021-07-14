import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'game_object.dart';

// class that handles the missile bounding box that is moving towards
// it's destination
class Missile extends GameObjectRect {
  Vector2 missileDirection = Vector2.zero();
  double missileSpeed;

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
        );

  void setPosition(Vector2 position) {
    super.setPosition(position);
  }

  Vector2 get position {
    return super.position;
  }

  // moves the missile in it's direction
  void update(double dt) {
    super.update(dt);
    super.position.add(missileDirection * missileSpeed * dt);
  }

  // draws the missile
  void render(Canvas canvas) {
    super.render(canvas);
  }
}
