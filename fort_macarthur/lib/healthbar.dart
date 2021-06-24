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
  static int opacity = 1;
  static const PaletteEntry bg = BasicPalette.white;

  static const fading = [
    PaletteEntry(Color(0xFFFF0000)),
    PaletteEntry(Color(0x9FFF0000)),
    PaletteEntry(Color(0x9EFF0000)),
    PaletteEntry(Color(0x9DFF0000)),
    PaletteEntry(Color(0x9CFF0000)),
    PaletteEntry(Color(0x9BFF0000)),
    PaletteEntry(Color(0x9AFF0000)),
    PaletteEntry(Color(0x99FF0000)),
    PaletteEntry(Color(0x98FF0000)),
    PaletteEntry(Color(0x97FF0000)),
    PaletteEntry(Color(0x96FF0000)),
    PaletteEntry(Color(0x95FF0000)),
    PaletteEntry(Color(0x94FF0000)),
    PaletteEntry(Color(0x93FF0000)),
    PaletteEntry(Color(0x92FF0000)),
    PaletteEntry(Color(0x91FF0000)),
    PaletteEntry(Color(0x90FF0000)),
    PaletteEntry(Color(0x8FFF0000)),
    PaletteEntry(Color(0x8EFF0000)),
    PaletteEntry(Color(0x8DFF0000)),
    PaletteEntry(Color(0x8CFF0000)),
    PaletteEntry(Color(0x8BFF0000)),
    PaletteEntry(Color(0x8AFF0000)),
    PaletteEntry(Color(0x89FF0000)),
    PaletteEntry(Color(0x88FF0000)),
    PaletteEntry(Color(0x87FF0000)),
    PaletteEntry(Color(0x86FF0000)),
    PaletteEntry(Color(0x85FF0000)),
    PaletteEntry(Color(0x84FF0000)),
    PaletteEntry(Color(0x83FF0000)),
    PaletteEntry(Color(0x82FF0000)),
    PaletteEntry(Color(0x81FF0000)),
    PaletteEntry(Color(0x80FF0000)),
    PaletteEntry(Color(0x7FFF0000)),
    PaletteEntry(Color(0x7EFF0000)),
    PaletteEntry(Color(0x7DFF0000)),
    PaletteEntry(Color(0x7CFF0000)),
    PaletteEntry(Color(0x7BFF0000)),
    PaletteEntry(Color(0x7AFF0000)),
    PaletteEntry(Color(0x79FF0000)),
    PaletteEntry(Color(0x78FF0000)),
    PaletteEntry(Color(0x77FF0000)),
    PaletteEntry(Color(0x76FF0000)),
    PaletteEntry(Color(0x75FF0000)),
    PaletteEntry(Color(0x74FF0000)),
    PaletteEntry(Color(0x73FF0000)),
    PaletteEntry(Color(0x72FF0000)),
    PaletteEntry(Color(0x71FF0000)),
    PaletteEntry(Color(0x70FF0000)),
    PaletteEntry(Color(0x6FFF0000)),
    PaletteEntry(Color(0x6EFF0000)),
    PaletteEntry(Color(0x6DFF0000)),
    PaletteEntry(Color(0x6CFF0000)),
    PaletteEntry(Color(0x6BFF0000)),
    PaletteEntry(Color(0x6AFF0000)),
    PaletteEntry(Color(0x69FF0000)),
    PaletteEntry(Color(0x68FF0000)),
    PaletteEntry(Color(0x67FF0000)),
    PaletteEntry(Color(0x66FF0000)),
    PaletteEntry(Color(0x65FF0000)),
    PaletteEntry(Color(0x64FF0000)),
    PaletteEntry(Color(0x63FF0000)),
    PaletteEntry(Color(0x62FF0000)),
    PaletteEntry(Color(0x61FF0000)),
    PaletteEntry(Color(0x60FF0000)),
    PaletteEntry(Color(0x5FFF0000)),
    PaletteEntry(Color(0x5EFF0000)),
    PaletteEntry(Color(0x5DFF0000)),
    PaletteEntry(Color(0x5CFF0000)),
    PaletteEntry(Color(0x5BFF0000)),
    PaletteEntry(Color(0x5AFF0000)),
    PaletteEntry(Color(0x59FF0000)),
    PaletteEntry(Color(0x58FF0000)),
    PaletteEntry(Color(0x57FF0000)),
    PaletteEntry(Color(0x56FF0000)),
    PaletteEntry(Color(0x55FF0000)),
    PaletteEntry(Color(0x54FF0000)),
    PaletteEntry(Color(0x53FF0000)),
    PaletteEntry(Color(0x52FF0000)),
    PaletteEntry(Color(0x51FF0000)),
    PaletteEntry(Color(0x50FF0000)),
    PaletteEntry(Color(0x4FFF0000)),
    PaletteEntry(Color(0x4EFF0000)),
    PaletteEntry(Color(0x4DFF0000)),
    PaletteEntry(Color(0x4CFF0000)),
    PaletteEntry(Color(0x4BFF0000)),
    PaletteEntry(Color(0x4AFF0000)),
    PaletteEntry(Color(0x49FF0000)),
    PaletteEntry(Color(0x48FF0000)),
    PaletteEntry(Color(0x47FF0000)),
    PaletteEntry(Color(0x46FF0000)),
    PaletteEntry(Color(0x45FF0000)),
    PaletteEntry(Color(0x44FF0000)),
    PaletteEntry(Color(0x43FF0000)),
    PaletteEntry(Color(0x42FF0000)),
    PaletteEntry(Color(0x41FF0000)),
    PaletteEntry(Color(0x40FF0000)),
    PaletteEntry(Color(0x3FFF0000)),
    PaletteEntry(Color(0x3EFF0000)),
    PaletteEntry(Color(0x3DFF0000)),
    PaletteEntry(Color(0x3CFF0000)),
    PaletteEntry(Color(0x3BFF0000)),
    PaletteEntry(Color(0x3AFF0000)),
    PaletteEntry(Color(0x39FF0000)),
    PaletteEntry(Color(0x38FF0000)),
    PaletteEntry(Color(0x37FF0000)),
    PaletteEntry(Color(0x36FF0000)),
    PaletteEntry(Color(0x35FF0000)),
    PaletteEntry(Color(0x34FF0000)),
    PaletteEntry(Color(0x33FF0000)),
    PaletteEntry(Color(0x32FF0000)),
    PaletteEntry(Color(0x31FF0000)),
    PaletteEntry(Color(0x30FF0000)),
    PaletteEntry(Color(0x2FFF0000)),
    PaletteEntry(Color(0x2EFF0000)),
    PaletteEntry(Color(0x2DFF0000)),
    PaletteEntry(Color(0x2CFF0000)),
    PaletteEntry(Color(0x2BFF0000)),
    PaletteEntry(Color(0x2AFF0000)),
    PaletteEntry(Color(0x29FF0000)),
    PaletteEntry(Color(0x28FF0000)),
    PaletteEntry(Color(0x27FF0000)),
    PaletteEntry(Color(0x26FF0000)),
    PaletteEntry(Color(0x25FF0000)),
    PaletteEntry(Color(0x24FF0000)),
    PaletteEntry(Color(0x23FF0000)),
    PaletteEntry(Color(0x22FF0000)),
    PaletteEntry(Color(0x21FF0000)),
    PaletteEntry(Color(0x20FF0000)),
    PaletteEntry(Color(0x1FFF0000)),
    PaletteEntry(Color(0x1EFF0000)),
    PaletteEntry(Color(0x1DFF0000)),
    PaletteEntry(Color(0x1CFF0000)),
    PaletteEntry(Color(0x1BFF0000)),
    PaletteEntry(Color(0x1AFF0000)),
    PaletteEntry(Color(0x19FF0000)),
    PaletteEntry(Color(0x18FF0000)),
    PaletteEntry(Color(0x17FF0000)),
    PaletteEntry(Color(0x16FF0000)),
    PaletteEntry(Color(0x15FF0000)),
    PaletteEntry(Color(0x14FF0000)),
    PaletteEntry(Color(0x13FF0000)),
    PaletteEntry(Color(0x12FF0000)),
    PaletteEntry(Color(0x11FF0000)),
    PaletteEntry(Color(0x10FF0000)),
    PaletteEntry(Color(0x0FFF0000)),
    PaletteEntry(Color(0x0EFF0000)),
    PaletteEntry(Color(0x0DFF0000)),
    PaletteEntry(Color(0x0CFF0000)),
    PaletteEntry(Color(0x0BFF0000)),
    PaletteEntry(Color(0x0AFF0000)),
    PaletteEntry(Color(0x09FF0000)),
    PaletteEntry(Color(0x08FF0000)),
    PaletteEntry(Color(0x07FF0000)),
    PaletteEntry(Color(0x06FF0000)),
    PaletteEntry(Color(0x05FF0000)),
    PaletteEntry(Color(0x04FF0000)),
    PaletteEntry(Color(0x03FF0000)),
    PaletteEntry(Color(0x02FF0000)),
    PaletteEntry(Color(0x01FF0000)),
    PaletteEntry(Color(0x00FF0000)),
  ];

  Palette() {
    bg.withAlpha(opacity);
  }
}

class HealthBar extends PositionComponent {
  static double health = 10.0;
  static int currentFade = 0;
  Paint bgColor = Palette.bg.paint;
  late Paint barColor;

  HealthBar() {
    barColor = Palette.fading[0].paint;
  }

  @override
  void render(Canvas c) {
    prepareCanvas(c);

    c.drawRect(Rect.fromLTWH(0, 0, width, height), bgColor);
    c.drawRect(const Rect.fromLTWH(0, 0, 3, 3), barColor);
    // fading[0] is pure red, fading[100] is completely opaque
  }

  void applyPaint() {
    barColor = Palette.fading[currentFade].paint;
  }

  void fadeIn() {
    if (currentFade < 100) {
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
