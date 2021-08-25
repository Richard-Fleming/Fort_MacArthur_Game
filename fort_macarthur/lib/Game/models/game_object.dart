import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:fort_macarthur/Game/models/healthbar.dart';
import '../models/enemyplane.dart';

class GameObjectRect extends PositionComponent {
  late Rectangle collider;
  late Paint paint;
  Vector2 position;
  Vector2 size;
  double angle;

  // generic rectangle shape object. can be rotated, resized, and moved.
  GameObjectRect(
      {required this.size,
      required Color color,
      required this.position,
      this.angle = 0.0}) {
    paint = new Paint()..color = color;
    collider = new Rectangle(size: size, angle: angle);
    collider.offsetPosition = position;
  }

  void setPosition(Vector2 position) {
    this.position = position;
  }

  void setAngle(double angle) {
    this.angle = angle;
  }

  void setSize(Vector2 size) {
    this.size = size;
  }

  // calculates angle to face the direction passed.
  // far from perfect
  void faceDirection(Vector2 direction) {
    this.angle = atan2(direction.y, direction.x);
  }

  // returns center of the rectangle
  Vector2 getCenter() {
    return Vector2(size.x / 2, size.y / 2);
  }

  // updates the shape's properties
  void update(double dt) {
    super.update(dt);
    collider.offsetPosition = this.position;
    collider.angle = this.angle;
    collider.size = this.size;
  }

  // render the shape
  // ignore: must_call_super
  void render(Canvas canvas) {
    collider.render(canvas, paint);
  }
}

// generic circle shape object. mainly used for the explosions
class GameObjectCircle {
  late Circle collider;
  late Paint paint;
  Vector2 position;
  double radius;

  GameObjectCircle(
      {required this.radius, required Color color, required this.position}) {
    paint = new Paint()..color = color;
    collider = new Circle(position: position, radius: radius);
  }

  void setPosition(Vector2 position) {
    this.position = position;
    collider = new Circle(position: this.position, radius: radius);
  }

  void setRadius(double radius) {
    this.radius = radius;
    collider = new Circle(position: this.position, radius: radius);
  }

  // returns the center
  Vector2 center() {
    return Vector2(collider.radius, collider.radius);
  }

  // updates the cirlce shape
  void update(double dt) {
    collider = new Circle(position: position, radius: radius);
  }

  // update the radius size
  void updateRadius(double increase, double dt) {
    this.radius += increase * dt;
  }

  // draw the shape
  void render(Canvas canvas) {
    canvas.drawCircle(collider.position.toOffset(), radius, paint);
  }
}
