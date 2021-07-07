import 'dart:ui';

import 'ammo.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'healthbar.dart';
import 'enemyplane.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:fort_macarthur/ammo.dart';
import 'package:fort_macarthur/healthbar.dart';
import 'missile_system.dart';

// main game loop. pan detector necessary for touch detection
class GameLoop extends BaseGame with PanDetector, TapDetector {
  MissileSystem missileSystem = new MissileSystem();

  bool isPressed = false;
  var healthbar = new HealthBar(100, 100);
  var ammoManager = new AmmunitionManager();

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
    missileSystem.setupDestination(details);
  }

  // continued touch dragging movement
  void onPanUpdate(DragUpdateInfo details) {
    missileSystem.moveDestination(details);
  }

  // when the touch ends
  void onPanEnd(DragEndInfo details) {
    missileSystem.launchMissile();
  }

  // updates game
  void update(double dt) {
    super.update(dt);
    missileSystem.update(dt);
    healthbar.update(dt);

    // put anything to be updated such here
  }

  // renders objects to the canvas
  void render(Canvas canvas) {
    super.render(canvas);
    missileSystem.render(canvas);
    ammoManager.draw(canvas);
    healthbar.render(canvas);
  }

  // changes the background color
  Color backgroundColor() => const Color(0xFF666666);
}
