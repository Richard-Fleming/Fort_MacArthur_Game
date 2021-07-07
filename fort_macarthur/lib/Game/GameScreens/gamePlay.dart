import 'dart:ui';

import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fort_macarthur/Game/game_loop.dart';

class GamePlay extends GameLoop {
  bool _isGameOver = false;

  /* GamePlay() {} */

  // function for loading in assets and initializing classes
  Future<void> onLoad() async {}

// touch start
  void onTapDown(TapDownInfo event) {}

  // drag motion started
  void onPanStart(DragStartInfo details) {}

  // continued touch dragging movement
  void onPanUpdate(DragUpdateInfo details) {}

  // when the touch ends
  void onPanEnd(DragEndInfo details) {}

  // updates game
  void update(double dt) {
    super.update(dt);
  }

  // renders objects to the canvas
  void render(Canvas canvas) {
    super.render(canvas);
  }

  // changes the background color
  Color backgroundColor() => const Color(0xFF666666);

  void _gameOver() {}
}
