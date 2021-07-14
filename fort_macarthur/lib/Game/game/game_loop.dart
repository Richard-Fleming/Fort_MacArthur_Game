import 'dart:ui';

import '../models/ammo.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame/components.dart'; // Needed for Anchor class
import '../models/healthbar.dart';
import '../models/enemyplane.dart';
import '../models/missile_system.dart';

// main game loop. pan detector necessary for touch detection
class GameLoop extends BaseGame with PanDetector, TapDetector {
  MissileSystem missileSystem = new MissileSystem();

  int enemyCount = 3;

  bool isPressed = false;
  late HealthBar healthbar;
  var ammoManager = new AmmunitionManager();

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
    if (event.eventPosition.game.x < 400 && event.eventPosition.game.y < 75) {
      // if they tap the top right of the screen,
      // pause the game
      paused = !paused;
    }

    if (!paused) {
      isPressed = true;
      healthbar.setFade(isPressed);
      ammoManager.onTapDown(event);
      missileSystem.launchMissileOnTap(event);
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
    if (!paused) {
      isPressed = false;
      healthbar.setFade(isPressed);
    }
  }

  // drag motion started
  void onPanStart(DragStartInfo details) {
    if (!paused) missileSystem.setupDestination(details);
  }

  // continued touch dragging movement
  void onPanUpdate(DragUpdateInfo details) {
    if (!paused) missileSystem.moveDestination(details);
  }

  // when the touch ends
  void onPanEnd(DragEndInfo details) {
    if (!paused) missileSystem.launchMissile();
  }

  // updates game
  void update(double dt) {
    if (!paused) {
      super.update(dt);
      missileSystem.update(dt);
      healthbar.update(dt);
    }

    // put anything to be updated such here
  }

  // renders objects to the canvas
  void render(Canvas canvas) {
    super.render(canvas);
    missileSystem.render(canvas);
    ammoManager.draw(canvas);
    healthbar.render(canvas);

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
