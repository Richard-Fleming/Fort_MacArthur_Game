import 'dart:ui';

import 'package:fort_macarthur/Game/GameScreens/screenState.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';

ScreenManager screenManager = ScreenManager();

class ScreenManager extends Game with TapDetector {
  late Function _fn;
  ScreenState _screenState = ScreenState.fMenuScreen;

  @override
  void render(Canvas canvas) {
    // TODO: implement render
  }

  @override
  void update(double dt) {
    // TODO: implement update
  }
}
