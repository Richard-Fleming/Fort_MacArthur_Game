import 'dart:ui';

import 'ammo.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'GameScreens/screenState.dart';
import 'package:flame/components.dart'; // Needed for Anchor class
import 'healthbar.dart';
import 'enemyplane.dart';
import 'missile_system.dart';
import 'buttons.dart';

// main game loop. pan detector necessary for touch detection
class GameLoop extends BaseGame with PanDetector, TapDetector {
  MissileSystem missileSystem = new MissileSystem();
  Screens _currentScreen = Screens.menu;

  int enemyCount = 3;

  bool isPressed = false;
  late HealthBar healthbar;
  var ammoManager = new AmmunitionManager();
  var startButton = new Button(120, 110, 160, 60, 200, 110, 'START');
  var optionButton = new Button(90, 250, 220, 60, 200, 250, 'OPTIONS');
  var quitButton = new Button(120, 390, 160, 60, 200, 390, 'QUIT');
  var backButton = new Button(120, 390, 160, 60, 200, 390, 'BACK');

  TextPaint textPaint = TextPaint(
      config: TextPaintConfig(
    fontSize: 20.0,
    fontFamily: 'Awesome Font',
  ));

  bool paused = false;

  // function for loading in assets and initializing classes
  Future<void> onLoad() async {
    // put image loading, class initialization here
    healthbar = HealthBar(size.x / 1.5, size.y - 50);
    add(healthbar);

    for (var i = 0; i < enemyCount; i++) {
      add(EnemyPlane(size, healthbar));
    }
    missileSystem.baseInit(size);
  }

  // touch start
  void onTapDown(TapDownInfo event) {
<<<<<<< HEAD
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
		    if (!paused) {
          healthbar.setFade(isPressed);
          ammoManager.onTapDown(event);
          missileSystem.launchMissileOnTap(event);
		  }
		  
		      if (event.eventPosition.game.x < 400 && event.eventPosition.game.y < 75) {
      // if they tap the top right of the screen,
      // pause the game
      paused = !paused;
    }
        }
        break;
      case Screens.options:
        {
          backButton.onTapDown(isPressed);
        }
        break;
      case Screens.endGame:
        {} break;
    }
  }

  // touch end
  void onTapUp(TapUpInfo event) {
    if (!paused) {
      isPressed = false;
      healthbar.setFade(isPressed);
      missileSystem.launchMissile();
    }

    if (event.eventPosition.game.x < 400 && event.eventPosition.game.y > 75)
      paused = false;
  }

  // touch cancelled
  void onTapCancel() {
<<<<<<< HEAD
    isPressed = false;
    if (_currentScreen == Screens.gamePlay) {
    if (!paused) {
      isPressed = false;
      healthbar.setFade(isPressed);
    }
  }

  // drag motion started
  void onPanStart(DragStartInfo details) {
    if (_currentScreen == Screens.gamePlay) {
    if (!paused) missileSystem.setupDestination(details);
}
  }

  // continued touch dragging movement
  void onPanUpdate(DragUpdateInfo details) {
<<<<<<< HEAD
    if (_currentScreen == Screens.gamePlay) {

    if (!paused) missileSystem.moveDestination(details);
}
  }

  // when the touch ends
  void onPanEnd(DragEndInfo details) {
<<<<<<< HEAD
    if (_currentScreen == Screens.gamePlay) {
    if (!paused) missileSystem.launchMissile();
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
		    if (!paused) {
          missileSystem.update(dt);
          healthbar.update(dt);
		  }

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

    //TODO: Remove this when proper Enemy Manager is implemented.
    if (!paused) {
      textPaint.render(
          canvas, enemyCount.toString() + ' Enemies Remain', Vector2(95, 10),
          anchor: Anchor.topCenter);
    } else {
      textPaint.render(canvas, 'Paused...', Vector2(95, 10),
          anchor: Anchor.topCenter);
    }

    textPaint.render(canvas, "Pause", Vector2(375, 10),
        anchor: Anchor.topCenter);
  }

  // changes the background color
  Color backgroundColor() => const Color(0xFF666666);
}
