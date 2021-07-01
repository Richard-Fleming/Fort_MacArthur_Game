import 'dart:ui';

import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fort_macarthur/Game/game_loop.dart';

import '../missileSystem.dart';

class GamePlay extends GameLoop {
  bool _isGameOver = false;
  MissileSystem missileSystem = new MissileSystem();

  /* GamePlay() {} */

  // function for loading in assets and initializing classes
  Future<void> onLoad() async {
    missileSystem.baseInit(size);
  }

// touch start
  void onTapDown(TapDownInfo event) {
    missileSystem.launchMissileOnTap(event);
  }

  // drag motion started
  void onPanStart(DragStartInfo details) {
    missileSystem.setupDestination(details);
  }

  // continued touch dragging movement
  void onPanUpdate(DragUpdateInfo details) {
    missileSystem.moveDestination(details);
  }

  // when the touch ends
  void onPanEnd(DragEndInfo details) {
    missileSystem.launchMissile(details);
  }

  // updates game
  void update(double dt) {
    super.update(dt);
    missileSystem.update(dt);
  }

  // renders objects to the canvas
  void render(Canvas canvas) {
    super.render(canvas);
    missileSystem.render(canvas);
  }

  // changes the background color
  Color backgroundColor() => const Color(0xFF666666);

  void _gameOver() {}
}
