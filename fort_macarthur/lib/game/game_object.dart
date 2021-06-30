import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class GameObjectRect {
  late Rect collider;
  late Paint paint;
  Vector2 position;
  Vector2 size;

  GameObjectRect(
      {required this.size, required Color color, required this.position}) {
    paint = new Paint()..color = color;
    collider = new Rect.fromLTWH(position.x, position.y, size.x, size.y);
  }

  void setPosition(Vector2 position) {
    this.position = position;
    collider =
        new Rect.fromLTWH(this.position.x, this.position.y, size.x, size.y);
  }

  // void setRotation(double rotation){
  //   collider.
  // }

  Vector2 centerPoint() {
    return Vector2(size.x / 2, size.y / 2);
  }

  Vector2 center() {
    return Vector2(collider.center.dx, collider.center.dy);
  }

  void update(double dt) {
    collider = new Rect.fromLTWH(position.x, position.y, size.x, size.y);
  }

  void render(Canvas canvas) {
    canvas.drawRect(collider, paint);
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
