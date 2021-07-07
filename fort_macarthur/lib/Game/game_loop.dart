import 'dart:ui';

import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:fort_macarthur/Game/GameScreens/screens.dart';

import 'package:fort_macarthur/Game/GameScreens/mainMenu.dart';

// main game loop. pan detector necessary for touch detection
abstract class GameLoop {
  Screen activeScreen = Screen.mainMenu;
  late MainMenu mainMenu;

  // function for loading in assets and initializing classes
  Future<void> onLoad() async {
    mainMenu = MainMenu();
  }

  // touch start
  void onTapDown(TapDownInfo event) {}

  // drag motion started
  void onPanStart(DragStartInfo details) {}

  // continued touch dragging movement
  void onPanUpdate(DragUpdateInfo details) {}

  // when the touch ends
  void onPanEnd(DragEndInfo details) {}

  // updates game
  void update(double dt) {}

  // renders objects to the canvas
  void render(Canvas canvas) {}

  // changes the background color
  Color backgroundColor() => const Color(0xFF666666);
}
