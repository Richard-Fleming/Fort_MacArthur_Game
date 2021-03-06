import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';

class AmmunitionManager {
  final buttonSize = Vector2(30, 30);
  int ammoLeft = 5;
  TextPaint textPaint = TextPaint(
      config: TextPaintConfig(
    fontSize: 24.0,
    fontFamily: 'Awesome Font',
  ));

  void reset() {
    ammoLeft = 5;
  }

  void onTapDown(TapDownInfo event) {
    //print("Player tap down on ${event.eventPosition.game}");
    //decreaseAmmo(1);
    //fulfilledincreaseAmmo(1);
  }

  increaseAmmo(int value) {
    if (ammoLeft < 20) {
      ammoLeft += value;
    }
  }

  decreaseAmmo(int value) {
    if (ammoLeft > 0) {
      ammoLeft -= value;
    }
  }

  draw(Canvas canvas) {
    textPaint.render(canvas, ammoLeft.toString() + '/20', Vector2(300, 500),
        anchor: Anchor.topCenter);
  }

  update(double dt) {}

  int getAmmo() {
    return ammoLeft;
  }
}
