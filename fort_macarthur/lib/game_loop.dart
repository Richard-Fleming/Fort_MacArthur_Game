import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'missile_system.dart';

// main game loop. pan detector necessary for touch detection
class GameLoop extends BaseGame with PanDetector {
  MissileSystem missileSystem = new MissileSystem();
  // Vector2 touchPosition = Vector2.zero();
  // late GameObjectRect base;

  // double explosionInitialRadius = 10;

  // GameObjectRect missile = new GameObjectRect(
  //     size: Vector2(10, 30),
  //     color: Color(0xFFFFFFFF),
  //     position: Vector2.zero());

  // GameObjectRect tap = new GameObjectRect(
  //     size: Vector2(10, 10),
  //     color: Color(0xFFFFFFFF),
  //     position: Vector2.zero());

  // GameObjectCircle explosion = new GameObjectCircle(
  //     radius: 20, color: Color(0xFFFFFFFF), position: Vector2.zero());

  // bool missileLaunched = false;
  // bool explosionTriggered = false;
  // bool explosionVisible = false;
  // double missileSpeed = 300;
  // Vector2 missileDirection = Vector2.zero();

  // Vector2 lineStart = Vector2.zero();

  // Paint whiteBox = new Paint()..color = Color(0xFFFFFFFF);

  // bool isPressed = false;

  // function for loading in assets and initializing classes
  Future<void> onLoad() async {
    // base = new GameObjectRect(
    //     size: Vector2(50, 30),
    //     color: Color(0xFFFFFFFF),
    //     position: Vector2((size.x / 2) - 30, size.y - 30));
    // lineStart = base.center();
  }

  // void onPanStart(DragStartInfo details) {
  //   if (!missileLaunched) {
  //     isPressed = true;
  //     tap.setPosition(
  //         Vector2(details.eventPosition.game.x, details.eventPosition.game.y));
  //     missile.setPosition(base.center());
  //     missileDirection = (tap.position - missile.position).normalized();
  //   }
  // }

  // void onPanUpdate(DragUpdateInfo details) {
  //   if (!missileLaunched) {
  //     isPressed = true;
  //     tap.setPosition(
  //         Vector2(details.eventPosition.game.x, details.eventPosition.game.y));
  //     missile.setPosition(base.center());
  //     missileDirection = (tap.position - missile.position).normalized();
  //   }
  // }

  // void onPanEnd(DragEndInfo details) {
  //   if (!missileLaunched && tap.position.y < base.position.y) {
  //     missileLaunched = true;
  //     isPressed = true;
  //   } else {
  //     isPressed = false;
  //   }
  // }

  // void onTapDown(TapDownInfo event) {
  //   if (!missileLaunched) {
  //     isPressed = true;
  //     tap.setPosition(
  //         Vector2(event.eventPosition.game.x, event.eventPosition.game.y));
  //     missile.setPosition(base.center());
  //     missileDirection = (tap.position - missile.position).normalized();
  //   }
  // }

  // void explode() async {
  //   explosionTriggered = false;
  //   await Future.delayed(Duration(milliseconds: 200), () {
  //     explosionVisible = false;
  //     explosion.setRadius(explosionInitialRadius);
  //   });
  // }

  // updates game
  void update(double dt) {
    super.update(dt);
    missileSystem.update(dt);
    // if (missileLaunched) {
    //   missile.update(dt);
    //   missile.position.add(missileDirection * missileSpeed * dt);

    //   if (missile.position.y < tap.position.y) {
    //     explosion.position = missile.position;
    //     explosionTriggered = true;
    //     explosionVisible = true;
    //     missile.setPosition(base.center());
    //     missileLaunched = false;
    //     isPressed = false;
    //   }
    // }

    // if (explosionTriggered) {
    //   explosion.update(dt);
    //   explosion.updateRadius(40, dt);
    //   if (explosion.radius > 60) {
    //     explode();
    //   }
    // }
  }

  // renders objects to the canvas
  void render(Canvas canvas) {
    super.render(canvas);
    missileSystem.render(canvas);
    // base.render(canvas);
    // if (missileLaunched) {
    //   missile.render(canvas);
    // }

    // if (isPressed || missileLaunched) {
    //   tap.render(canvas);
    //   canvas.drawLine(lineStart.toOffset(), tap.position.toOffset(), whiteBox);
    // }

    // if (explosionVisible) {
    //   explosion.render(canvas);
    // }
  }

  // changes the background color
  Color backgroundColor() => const Color(0xFF666666);
}
