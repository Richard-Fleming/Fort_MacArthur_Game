import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';

import 'game_object.dart';

// class that handles tap events, launching missiles, and detonating
// the missiles
class MissileSystem {
  Vector2 touchPosition = Vector2.zero();
  Vector2 lineStart = Vector2.zero();
  Vector2 missileDirection = Vector2.zero();

  late GameObjectRect base;
  late GameObjectRect missile;
  late GameObjectRect tap;

  double missileSpeed = 300;
  double explosionInitialRadius = 10;

  bool missileLaunched = false;
  bool explosionTriggered = false;
  bool explosionVisible = false;
  bool isPressed = false;

  Paint whiteBox = new Paint()..color = Color(0xFFFFFFFF);

  MissileSystem() {
    missile = new GameObjectRect(
        size: Vector2(10, 30),
        color: Color(0xFFFFFFFF),
        position: Vector2.zero());

    tap = new GameObjectRect(
        size: Vector2(10, 10),
        color: Color(0xFFFFFFFF),
        position: Vector2.zero());

    base = new GameObjectRect(
        size: Vector2.zero(),
        color: Color(0xFFFFFFFF),
        position: Vector2.zero());
  }

  void baseInit(Vector2 displaySize) {
    base = new GameObjectRect(
      size: Vector2(50, 30),
      color: Color(0xFFFFFFFF),
      position: Vector2((displaySize.x / 2) - 30, displaySize.y - 30),
    );

    lineStart = base.center();
  }

  void launchMissileOnTap(TapDownInfo event) {
    if (!missileLaunched) {
      isPressed = true;
      tap.setPosition(
          Vector2(event.eventPosition.game.x, event.eventPosition.game.y) -
              tap.centerPoint());
      missileDirection = (tap.position - missile.position).normalized();
    }
  }

  void setupDestination(DragStartInfo details) {
    if (!missileLaunched) {
      isPressed = true;
      tap.setPosition(
          Vector2(details.eventPosition.game.x, details.eventPosition.game.y) -
              tap.centerPoint());
      missile.setPosition(base.center());
      missileDirection = (tap.position - missile.position).normalized();
    }
  }

  void moveDestination(DragUpdateInfo details) {
    if (!missileLaunched) {
      isPressed = true;
      tap.setPosition(
          Vector2(details.eventPosition.game.x, details.eventPosition.game.y) -
              tap.centerPoint());
      missile.setPosition(base.center());
      missileDirection = (tap.position - missile.position).normalized();
    }
  }

  void launchMissile(DragEndInfo details) {
    if (!missileLaunched && tap.position.y < base.position.y) {
      missileLaunched = true;
      isPressed = true;
    } else {
      isPressed = false;
    }
  }

  void update(double dt) {
    if (missileLaunched) {
      missile.update(dt);
      missile.position.add(missileDirection * missileSpeed * dt);
    }
  }

  void render(Canvas canvas) {
    base.render(canvas);
    if (missileLaunched) {
      missile.render(canvas);
    }

    if (isPressed || missileLaunched) {
      tap.render(canvas);
      canvas.drawLine(lineStart.toOffset(),
          (tap.position + tap.centerPoint()).toOffset(), whiteBox);
    }
  }
}
