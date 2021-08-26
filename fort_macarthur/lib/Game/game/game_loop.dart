import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fort_macarthur/Game/overlays/game_over_menu.dart';
//import 'package:fort_macarthur/Game/overlays/quizMenu.dart';
import '../models/ammo.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/components.dart'; // Needed for Anchor class
import '../models/healthbar.dart';
import '../models/enemyplane.dart';
import '../models/missile_system.dart';
import '../models/upgrades.dart';

// main game loop. pan detector necessary for touch detection
class GameLoop extends BaseGame with PanDetector, TapDetector, HasCollidables {
  MissileSystem missileSystem = new MissileSystem();
  int enemyCount = 3;
  bool isPressed = false;
  bool isAlreadyLoaded = false;
  late HealthBar healthbar;
  late EnemyPlane enemy;

  var ammoManager = new AmmunitionManager();

  TextPaint textPaint = TextPaint(
      config: TextPaintConfig(
    fontSize: 20.0,
    fontFamily: 'Awesome Font',
  ));

  // function for loading in assets and initializing classes
  Future<void> onLoad() async {
    // Check as if navigating between menuand gameplay it will be called multiple times
    if (!isAlreadyLoaded) {
      // put image loading, class initialization here
      healthbar = HealthBar(size.x / 1.5, size.y - 50);
      add(healthbar);
      enemy = EnemyPlane(size, healthbar);
      add(enemy);
      missileSystem.baseInit(size);

      ammoManager.ammoLeft += finalTallyAmmo;
      healthbar.upgradeHealth(finalTallyHealth);
    }
  }

  // touch start
  void onTapDown(TapDownInfo event) {
    isPressed = true;
    healthbar.setFade(isPressed);
    ammoManager.onTapDown(event);
    missileSystem.launchMissileOnTap(event);
  }

  // touch end
  void onTapUp(TapUpInfo event) {
    isPressed = false;
    healthbar.setFade(isPressed);
    missileSystem.launchMissile();
  }

  // touch cancelled
  void onTapCancel() {
    isPressed = false;
    healthbar.setFade(isPressed);
  }

  // drag motion started
  void onPanStart(DragStartInfo details) {
    isPressed = true;
    healthbar.setFade(isPressed);
    missileSystem.setupDestination(details);
  }

  // continued touch dragging movement
  void onPanUpdate(DragUpdateInfo details) {
    isPressed = true;
    healthbar.setFade(isPressed);
    missileSystem.moveDestination(details);
  }

  // when the touch ends
  void onPanEnd(DragEndInfo details) {
    isPressed = false;
    healthbar.setFade(isPressed);
    missileSystem.launchMissile();
  }

  //Resets game when navigating between menu and game screens for example
  void reset() {
    missileSystem.reset();

    components.whereType<EnemyPlane>().forEach((enemyPlane) {
      enemyPlane.stopSound();
      enemyPlane.remove();
    });

    healthbar.reset();
    ammoManager.reset();
  }

  // updates game
  void update(double dt) {
    super.update(dt);

    if (missileSystem.wasLaunched) {
      ammoManager.decreaseAmmo(1);
      missileSystem.wasLaunched = false;
    }

    missileSystem.update(dt);
    healthbar.update(dt);
    // Test quiz
    //if (healthbar.getHealth() == 0 || ammoManager.getAmmo() == 0) {
    //overlays.add(QuizMenu.ID);

    if (healthbar.getHealth() == 0 ||
        (ammoManager.getAmmo() == 0 && !missileSystem.missileLaunched)) {
      overlays.add(GameOverMenu.ID);
    }
  }

  // renders objects to the canvas
  void render(Canvas canvas) {
    super.render(canvas);
    missileSystem.render(canvas);
    ammoManager.draw(canvas);
    healthbar.render(canvas);

    //TODO: Remove this when proper Enemy Manager is implemented.

    textPaint.render(
        canvas, enemyCount.toString() + ' Enemies That Remain', Vector2(95, 10),
        anchor: Anchor.topCenter);
  }

  // changes the background color
  Color backgroundColor() => const Color(0xFF666666);
}
