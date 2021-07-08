import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class StartBar extends PositionComponent {
  late Paint bgColor;
  final double left;
  final double top;
  bool isPressed = false;

  StartBar(this.left, this.top) {
    // bar color starts out opaque
    applyPaint();
  }

  void applyPaint() {
    bgColor = Paint()..color = Color.fromARGB(255, 200, 200, 200);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    super.render(c);
    c.drawRect(Rect.fromLTWH(left, top, 200, 50), bgColor);
  }
}
