import 'dart:math';

import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class GameObjectRect {
  late Rectangle collider;
  late Paint paint;
  Vector2 position;
  Vector2 size;
  double angle;

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

  void faceDirection(Vector2 direction) {
    this.angle = atan2(direction.y, direction.x);
  }

  Vector2 center() {
    return Vector2(size.x / 2, size.y / 2);
  }

  void update(double dt) {
    collider.offsetPosition = this.position;
    collider.angle = this.angle;
  }

  void render(Canvas canvas) {
    collider.render(canvas, paint);
  }
}

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

  Vector2 center() {
    return Vector2(collider.radius, collider.radius);
  }

  void update(double dt) {
    collider = new Circle(position: position, radius: radius);
  }

  void updateRadius(double increase, double dt) {
    this.radius += increase * dt;
  }

  void render(Canvas canvas) {
    canvas.drawCircle(collider.position.toOffset(), radius, paint);
  }
}
