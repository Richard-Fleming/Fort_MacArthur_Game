import 'dart:ui';

import 'package:fort_macarthur/Game/game_loop.dart';
import 'package:fort_macarthur/GameScreens/ScreenState.dart';
import 'package:flutter/src/gestures/tap.dart';

class MainMenu extends GameLoop {
  MainMenu() {}

  @override
  void render(Canvas canvas);

  @override
  void update(double t);

  @override
  void onTapDown(TapDownDetails detail, Function fn);
}
