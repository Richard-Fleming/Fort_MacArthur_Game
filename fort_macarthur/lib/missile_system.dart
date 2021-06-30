import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';

import 'game_object.dart';

// class that handles tap events, launching missiles, and detonating
// the missiles
class MissileSystem extends BaseGame with PanDetector {
  Vector2 touchPosition = Vector2.zero();
  Vector2 lineStart = Vector2.zero();
  Vector2 missileDirection = Vector2.zero();

  late GameObjectRect base;
  late GameObjectRect missile;
  late GameObjectRect tap;
  late GameObjectCircle explosion;

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

    explosion = new GameObjectCircle(
        radius: explosionInitialRadius,
        color: Color(0xFFFFFFFF),
        position: Vector2.zero());

    base = new GameObjectRect(
        size: Vector2.zero(),
        color: Color(0xFFFFFFFF),
        position: Vector2.zero());

    lineStart = base.center();
  }

  void baseInit() {
    base = new GameObjectRect(
      size: Vector2(50, 30),
      color: Color(0xFFFFFFFF),
      position: Vector2((size.x / 2) - 30, size.y - 30),
    );
  }

  Future<void> onLoad() async {
    baseInit();
  }

  void onPanStart(DragStartInfo details) {
    if (!missileLaunched) {
      isPressed = true;
      tap.setPosition(
          Vector2(details.eventPosition.game.x, details.eventPosition.game.y));
      missile.setPosition(base.center());
      missileDirection = (tap.position - missile.position).normalized();
    }
  }

  void onPanUpdate(DragUpdateInfo details) {
    if (!missileLaunched) {
      isPressed = true;
      tap.setPosition(
          Vector2(details.eventPosition.game.x, details.eventPosition.game.y));
      missile.setPosition(base.center());
      missileDirection = (tap.position - missile.position).normalized();
    }
  }

  void onPanEnd(DragEndInfo details) {
    if (!missileLaunched && tap.position.y < base.position.y) {
      missileLaunched = true;
      isPressed = true;
    } else {
      isPressed = false;
    }
  }

  void onTapDown(TapDownInfo event) {
    if (!missileLaunched) {
      isPressed = true;
      tap.setPosition(
          Vector2(event.eventPosition.game.x, event.eventPosition.game.y));
      missile.setPosition(base.center());
      missileDirection = (tap.position - missile.position).normalized();
    }
  }

  void explode() async {
    explosionTriggered = false;
    await Future.delayed(Duration(milliseconds: 200), () {
      explosionVisible = false;
      explosion.setRadius(explosionInitialRadius);
    });
  }

  void update(double dt) {
    super.update(dt);
    if (missileLaunched) {
      missile.update(dt);
      missile.position.add(missileDirection * missileSpeed * dt);

      if (missile.position.y < tap.position.y) {
        explosion.position = missile.position;
        explosionTriggered = true;
        explosionVisible = true;
        missile.setPosition(base.center());
        missileLaunched = false;
        isPressed = false;
      }
    }

    if (explosionTriggered) {
      explosion.update(dt);
      explosion.updateRadius(40, dt);
      if (explosion.radius > 60) {
        explode();
      }
    }
  }

  void render(Canvas canvas) {
    super.render(canvas);
    base.render(canvas);
    if (missileLaunched) {
      missile.render(canvas);
    }

    if (isPressed || missileLaunched) {
      tap.render(canvas);
      canvas.drawLine(lineStart.toOffset(), tap.position.toOffset(), whiteBox);
    }

    if (explosionVisible) {
      explosion.render(canvas);
    }
  }
}
