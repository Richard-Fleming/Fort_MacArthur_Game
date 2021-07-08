import 'dart:ui';

import 'ammo.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame/components.dart'; // Needed for Anchor class
import 'healthbar.dart';
import 'enemyplane.dart';
import 'missile_system.dart';

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

    //TODO: Remove this when proper Enemy Manager is implemented.
    textPaint.render(
        canvas, enemyCount.toString() + ' Enemies Remain', Vector2(95, 10),
        anchor: Anchor.topCenter);
  }

  // changes the background color
  Color backgroundColor() => const Color(0xFF666666);
}
