import 'dart:ui';

import 'ammo.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'GameScreens/screenState.dart';
import 'healthbar.dart';
import 'enemyplane.dart';
import 'missile_system.dart';
import 'buttons.dart';

// main game loop. pan detector necessary for touch detection
class GameLoop extends BaseGame with PanDetector, TapDetector {
  MissileSystem missileSystem = new MissileSystem();
  Screens _currentScreen = Screens.menu;

  bool isPressed = false;
  var healthbar = new HealthBar(100, 100);
  var ammoManager = new AmmunitionManager();
  var startButton = new Button(120, 110, 160, 60, 200, 110, 'START');
  var optionButton = new Button(90, 250, 220, 60, 200, 250, 'OPTIONS');
  var quitButton = new Button(120, 390, 160, 60, 200, 390, 'QUIT');
  var backButton = new Button(120, 390, 160, 60, 200, 390, 'BACK');

  // function for loading in assets and initializing classes
  Future<void> onLoad() async {
    // put image loading, class initialization here
    add(healthbar);

    for (int i = 0; i < 3; i++) {
      add(EnemyPlane(size, healthbar));
    }
    missileSystem.baseInit(size);
  }

  // touch start
  void onTapDown(TapDownInfo event) {
    isPressed = true;

    switch (_currentScreen) {
      case Screens.menu:
        {
          startButton.onTapDown(isPressed);
          optionButton.onTapDown(isPressed);
          quitButton.onTapDown(isPressed);
        }
        break;
      case Screens.gamePlay:
        {
          healthbar.setFade(isPressed);
          ammoManager.onTapDown(event);
          missileSystem.launchMissileOnTap(event);
        }
        break;
      case Screens.options:
        {
          backButton.onTapDown(isPressed);
        }
        break;
      case Screens.endGame:
        {}
    }
  }

  // touch end
  void onTapUp(TapUpInfo event) {
    isPressed = false;
    if (_currentScreen == Screens.gamePlay) {
      healthbar.setFade(isPressed);
      missileSystem.launchMissile();
    }
  }

  // touch cancelled
  void onTapCancel() {
    isPressed = false;
    if (_currentScreen == Screens.gamePlay) {
      healthbar.setFade(isPressed);
    }
  }

  // drag motion started
  void onPanStart(DragStartInfo details) {
    if (_currentScreen == Screens.gamePlay) {
      missileSystem.setupDestination(details);
    }
  }

  // continued touch dragging movement
  void onPanUpdate(DragUpdateInfo details) {
    if (_currentScreen == Screens.gamePlay) {
      missileSystem.moveDestination(details);
    }
  }

  // when the touch ends
  void onPanEnd(DragEndInfo details) {
    if (_currentScreen == Screens.gamePlay) {
      missileSystem.launchMissile();
    }
  }

  // updates game
  void update(double dt) {
    super.update(dt);

    switch (_currentScreen) {
      case Screens.menu:
        {
          if (isPressed == true && startButton.wasPressed() == true) {
            _currentScreen = Screens.gamePlay;
          } else if (isPressed == true && optionButton.wasPressed() == true) {
            _currentScreen = Screens.options;
          } else if (isPressed == true && quitButton.wasPressed() == true) {
            _currentScreen = Screens.endGame;
            print("Screens = " + _currentScreen.toString());
          }
        }
        break;
      case Screens.gamePlay:
        {
          missileSystem.update(dt);
          healthbar.update(dt);

          if (healthbar.dead == true) {
            _currentScreen = Screens.menu;
            healthbar.dead = false;
            print("We dead");
          }
        }
        break;
      case Screens.options:
        {
          if (isPressed == true && backButton.wasPressed() == true) {
            _currentScreen = Screens.menu;
          }
        }
        break;
      case Screens.endGame:
        {}
        break;
    }
  }
  // put anything to be updated such here

  // renders objects to the canvas
  void render(Canvas canvas) {
    super.render(canvas);
    if (_currentScreen == Screens.menu) {
      startButton.render(canvas);
      optionButton.render(canvas);
      quitButton.render(canvas);
    } else if (_currentScreen == Screens.gamePlay) {
      missileSystem.render(canvas);
      ammoManager.draw(canvas);
      healthbar.render(canvas);
    } else if (_currentScreen == Screens.options) {
      backButton.render(canvas);
    }
  }

  // changes the background color
  Color backgroundColor() => const Color(0xFF666666);
}
