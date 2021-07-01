import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';

class AmmunitionManager {
  final buttonSize = Vector2(30, 30);
  int ammo = 5;
  TextPaint textPaint = TextPaint(
      config: TextPaintConfig(
    fontSize: 24.0,
    fontFamily: 'Awesome Font',
  ));

  void onTapDown(TapDownInfo event) {
    //print("Player tap down on ${event.eventPosition.game}");
    decreaseAmmo(1);
    //fulfilledincreaseAmmo(1);
  }

  increaseAmmo(int value) {
    if (ammo < 20) {
      ammo += value;
    }
  }

  decreaseAmmo(int value) {
    if (ammo > 0) {
      ammo -= value;
    }
  }

  draw(Canvas canvas) {
    textPaint.render(canvas, ammo.toString() + '/20', Vector2(200, 10),
        anchor: Anchor.topCenter);
  }

  update(double dt) {}
}
