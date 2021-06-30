import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class HealthBar extends PositionComponent {
  static const int MAX_OPAQUE = 255;
  static double health = 10.0;
  static int currentFade = 255;
  late Paint barColor;
  final double left;
  final double top;

  HealthBar(this.left, this.top) {
    barColor = PaletteEntry(Color.fromARGB(MAX_OPAQUE, 255, 0, 0)).paint;
  }

  @override
  void render(Canvas c) {
    prepareCanvas(c);

    c.drawRect(Rect.fromLTWH(0, 0, health, 3), barColor);
  }

  void applyPaint() {
    barColor = PaletteEntry(Color.fromARGB(currentFade, 255, 0, 0)).paint;
  }

  void fadeIn() {
    if (currentFade < MAX_OPAQUE) {
      currentFade += 1;
      applyPaint();
    }
  }

  void fadeOut() {
    if (currentFade > 0) {
      currentFade -= 1;
      applyPaint();
    }
  }
}
