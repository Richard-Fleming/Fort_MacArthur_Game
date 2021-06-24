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
  static const PaletteEntry hpbar = PaletteEntry(Color(0xFFFF0000));
}

class Health extends PositionComponent {
  static double health = 10.0;
  static double opacity = 0.0;

  @override
  void render(Canvas c) {
    prepareCanvas(c);

    c.drawRect(Rect.fromLTWH(0, 0, width, height), Palette.bg.paint);
    c.drawRect(const Rect.fromLTWH(0, 0, 3, 3), Palette.hpbar.paint);
  }
}
