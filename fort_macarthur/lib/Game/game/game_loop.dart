import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fort_macarthur/Game/models/enemyplane.dart';
import 'package:fort_macarthur/Game/overlays/game_over_menu.dart';
import '../models/ammo.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/components.dart'; // Needed for Anchor class
import '../models/healthbar.dart';
import 'package:fort_macarthur/Game/models/enemyManager.dart';
import '../models/missile_system.dart';
import 'knowsGameSize.dart';

// main game loop. pan detector necessary for touch detection
class GameLoop extends BaseGame with PanDetector, TapDetector {
  MissileSystem missileSystem = new MissileSystem();

  bool isPressed = false;
  bool isAlreadyLoaded = false;
  late HealthBar healthbar;

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

      EnemyPlane enemy =
          EnemyPlane(enemyPos: viewport.canvasSize / 2 + Vector2(0, 100));

      missileSystem.baseInit(size);
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

  //Resets game when navigating between menu and game screens for example
  void reset() {
    missileSystem.reset();

    /* components.whereType<EnemyPlane>().forEach((enemyPlane) {
      enemyPlane.remove();
    }); */

    healthbar.reset();
    ammoManager.reset();
  }

  // updates game
  void update(double dt) {
    super.update(dt);
    missileSystem.update(dt);
    healthbar.update(dt);

    // If true we add gameover overlay
    if (healthbar.getHealth() == 0 || ammoManager.ammo == 0) {
      overlays.add(GameOverMenu.ID);
    }
  }

  @override
  void prepare(Component c) {
    super.prepare(c);

    if (c is KnowsGameSize) {
      c.onResize(this.size);
    }
  }

  @override
  void onResize(Vector2 canvasSize) {
    super.onResize(canvasSize);

    this.components.whereType<KnowsGameSize>().forEach((component) {
      component.onResize(this.size);
    });
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
