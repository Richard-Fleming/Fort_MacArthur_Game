import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/gestures.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Palette {
  static const PaletteEntry bg = BasicPalette.white;
}

class HealthBar extends PositionComponent {
  static const int MAX_OPAQUE = 255;
  static double health = 10.0;
  static int currentFade = 255;
  Paint bgColor = Palette.bg.paint;
  late Paint barColor;

  HealthBar() {
    barColor = PaletteEntry(Color.fromARGB(MAX_OPAQUE, 255, 0, 0)).paint;
  }

  @override
  void render(Canvas c) {
    prepareCanvas(c);

    c.drawRect(Rect.fromLTWH(0, 0, width, height), bgColor);
    c.drawRect(const Rect.fromLTWH(0, 0, 3, 3), barColor);
    // fading[0] is pure red, fading[100] is completely opaque
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
