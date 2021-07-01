import 'dart:ui';

import 'package:flame/components.dart';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';

class QuizGame {
  TextPaint textPaint = TextPaint(
      config: TextPaintConfig(
    fontSize: 24.0,
    fontFamily: 'Awesome Font',
  ));

  void onTapDown(TapDownInfo event) {
    //fulfilledincreaseAmmo(1);
  }

  buff(int value) {}

  debuff(int value) {}

  draw(Canvas canvas) {
    textPaint.render(canvas, "wah" + '/20', Vector2(200, 10),
        anchor: Anchor.topCenter);
  }

  update(double dt) {}
}
