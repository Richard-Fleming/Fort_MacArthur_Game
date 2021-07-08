import 'dart:ui';
import 'package:flutter/material.dart';

import 'GameScreens/screenState.dart';
import '../ammo.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'healthbar.dart';

// main game loop. pan detector necessary for touch detection
class GameLoop extends BaseGame with PanDetector, TapDetector {
  // function for loading in assets and initializing classes
  bool isPressed = false;
  var healthbar = new HealthBar(100, 100);
  var ammoManager = new AmmunitionManager();
  Screens _currentScreen = Screens.gamePlay;
  /* var startbar = new  */

  Future<void> onLoad() async {
    print('Loading Assets');
    // TODO sort out these pathing issues with sprites
  }

  void onTapDown(TapDownInfo event) {
    isPressed = true;
    if (_currentScreen == Screens.menu) {
    } else if (_currentScreen == Screens.gamePlay) {
      healthbar.setFade(isPressed);
      ammoManager.onTapDown(event);
    }
  }

  void onTapUp(TapUpInfo event) {
    isPressed = false;
    if (_currentScreen == Screens.gamePlay) {
      healthbar.setFade(isPressed);
    }
  }

  void onTapCancel() {
    isPressed = false;
    if (_currentScreen == Screens.gamePlay) {
      healthbar.setFade(isPressed);
    }
  }

  // updates game
  void update(double dt) {
    super.update(dt);

    print('Current Screen' + _currentScreen.toString());
    if (_currentScreen == Screens.gamePlay) {
      healthbar.update(dt);
    }

    // put anything to be updated such here
  }

  // renders objects to the canvas
  void render(Canvas canvas) {
    super.render(canvas);
    if (_currentScreen == Screens.menu) {
    } else if (_currentScreen == Screens.gamePlay) {
      ammoManager.draw(canvas);
      healthbar.render(canvas);
    }

    // put anything to be drawn here
  }

  // changes the background color
  Color backgroundColor() =>
      const Color(0xFF666666); // change this to RGB if you want
}
