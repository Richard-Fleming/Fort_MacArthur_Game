import 'dart:ui';
import 'package:flame/components.dart';

import 'ammo.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'healthbar.dart';
import 'game/enemyplane.dart';
import 'game/knows_game_size.dart';

// main game loop. pan detector necessary for touch detection
class GameLoop extends BaseGame with PanDetector, TapDetector {
  // function for loading in assets and initializing classes
  bool isPressed = false;
  var healthbar = new HealthBar(100, 100);
  var ammoManager = new AmmunitionManager();
  late EnemyPlane enemy;
  Future<void> onLoad() async {
    // put image loading, class initialization here
    add(healthbar);

    enemy = EnemyPlane();
    add(enemy);
  }

  void onTapDown(TapDownInfo event) {
    isPressed = true;
    healthbar.setFade(isPressed);
    healthbar.manageHealth(-1);
    ammoManager.onTapDown(event);
  }

  void onTapUp(TapUpInfo event) {
    isPressed = false;
    healthbar.setFade(isPressed);
  }

  void onTapCancel() {
    isPressed = false;
    healthbar.setFade(isPressed);
  }

  // updates game
  void update(double dt) {
    super.update(dt);
    healthbar.update(dt);

    /* if (isPressed && ammoManager.ammo > 0) {
      print("Fired");
    } else if (ammoManager.ammo == 0) {
      print("Ammo empty");
    }*/

    // put anything to be updated such here
  }

  // renders objects to the canvas
  void render(Canvas canvas) {
    super.render(canvas);
    ammoManager.draw(canvas);
    healthbar.render(canvas);

    // put anything to be drawn here
  }

  @override
  void prepare(Component c) {
    super.prepare(c);

    if (c is KnowsGameSize) c.onResize(this.size);
  }

  @override
  void onResize(Vector2 canvasSize) {
    super.onResize(canvasSize);

    this.components.whereType<KnowsGameSize>().forEach((component) {
      component.onResize(this.size);
    });
  }

  // changes the background color
  Color backgroundColor() =>
      const Color(0xFF666666); // change this to RGB if you want
}
