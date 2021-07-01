import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class EnemyPlane extends PositionComponent {
  final List<Vector2> startpoints = [
    Vector2(100.0, 100.0), // left starting point
    Vector2(100.0, 100.0), // middle starting point
    Vector2(100.0, 100.0), // right starting point
  ];

  final int startingpoint = 0;

  EnemyPlane();

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    super.render(c);
  }
}
