import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'GameScreens/screenState.dart';

class Button extends PositionComponent {
  TextPaint textPaint = TextPaint(
      config: TextPaintConfig(
    fontSize: 50.0,
    fontFamily: 'Awesome Font',
  ));
  bool isPressed = false;
  bool active = false;
  final double left;
  final double top;
  final double width;
  final double height;
  final double textLeft;
  final double textTop;
  final String txt;
  late Paint _white;

  Button(this.left, this.top, this.width, this.height, this.textLeft,
      this.textTop, this.txt) {
    // bar color starts out opaque
    applyPaint();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (wasPressed()) {
      active = true;
    } else {
      active = false;
    }
  }

  void onTapDown(bool pressed) {
    isPressed = pressed;
  }

  void applyPaint() {
    _white = Paint()..color = const Color(0xFFFFFFFF);
  }

  bool wasPressed() {
    return isPressed;
  }

  @override
  void render(Canvas c) {
    super.render(c);
    c.drawRect(Rect.fromLTWH(left, top, width, height), _white);
    textPaint.render(c, txt, Vector2(textLeft, textTop),
        anchor: Anchor.topCenter);
  }
}
