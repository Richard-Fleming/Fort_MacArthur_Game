import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:fort_macarthur/game/explosion.dart';
import 'package:fort_macarthur/game/missile.dart';

import 'game_object.dart';

// class that handles tap events, launching missiles, and detonating
// the missiles
class MissileSystem {
  Vector2 touchPosition = Vector2.zero();
  Vector2 lineStart = Vector2.zero();
  // Vector2 missileDirection = Vector2.zero();

  late GameObjectRect base;
  late Missile missile;
  late GameObjectRect tap;

  // allows for multiple explosions to go off at the same time
  List<Explosion> explosions = [];

  double missileSpeed = 300;
  double explosionInitialRadius = 10;

  bool missileLaunched = false;
  bool explosionTriggered = false;
  bool explosionVisible = false;
  bool isPressed = false;

  Paint whiteBox = new Paint()..color = Color(0xFFFFFFFF);

  // initializing all of the game objects
  MissileSystem() {
    missile = new Missile(
        size: Vector2(30, 10),
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

  // initializes game objects that need the screen size variable
  void baseInit(Vector2 displaySize) {
    base = new GameObjectRect(
      size: Vector2(50, 30),
      color: Color(0xFFFFFFFF),
      position: Vector2((displaySize.x / 2) - 30, displaySize.y - 30),
    );

    lineStart = base.position + base.center();
  }

  // launches missile on tap
  void launchMissileOnTap(TapDownInfo event) {
    if (!missileLaunched) {
      isPressed = true;

      tap.setPosition(
          Vector2(event.eventPosition.game.x, event.eventPosition.game.y) -
              tap.center());
      missile.setPosition(base.position + base.center());

      // missile direction calculations
      missile.missileDirection = (tap.position - missile.position).normalized();
      missile.faceDirection(missile.missileDirection);
    }
  }

  // sets up initial missile destination and line
  void setupDestination(DragStartInfo details) {
    if (!missileLaunched) {
      isPressed = true;
      tap.setPosition(
          Vector2(details.eventPosition.game.x, details.eventPosition.game.y) -
              tap.center());
      missile.setPosition(base.position + base.center());

      // missile direction calculations
      missile.missileDirection = (tap.position - missile.position).normalized();
      missile.faceDirection(missile.missileDirection);
    }
  }

  // updates the missile destination and line
  void moveDestination(DragUpdateInfo details) {
    if (!missileLaunched) {
      isPressed = true;
      tap.setPosition(
          Vector2(details.eventPosition.game.x, details.eventPosition.game.y) -
              tap.center());
      missile.setPosition(base.position + base.center());

      // missile direction calculations
      missile.missileDirection = (tap.position - missile.position).normalized();
      missile.faceDirection(missile.missileDirection);
    }
  }

  // launches the missile
  void launchMissile() {
    // checks if missile destination is not under the base
    if (isPressed && !missileLaunched && tap.position.y < base.position.y) {
      missileLaunched = true;
      isPressed = true;
    } else {
      isPressed = false;
    }
  }

  // updates the missile and checks if any explosions should go off
  void update(double dt) {
    if (isPressed || missileLaunched) {
      tap.update(dt);
    }

    // once the missile is launched
    if (missileLaunched) {
      missile.update(dt);

      // explosion happens when missile reaches it's destination
      if (missile.position.y < tap.position.y) {
        explosions.add(Explosion(position: missile.position));
        missile.setPosition(base.position + base.center());
        missileLaunched = false;
        isPressed = false;
      }
    }

    // update each active explosion and kill finished explosions
    for (int i = explosions.length - 1; i >= 0; --i) {
      explosions.elementAt(i).update(dt);
      if (!explosions.elementAt(i).alive) {
        explosions.removeAt(i);
      }
    }
  }

  // render objects to the screen when certain conditions are met
  void render(Canvas canvas) {
    base.render(canvas);
    if (missileLaunched) {
      missile.render(canvas);
    }

    if (isPressed || missileLaunched) {
      tap.render(canvas);
      canvas.drawLine(lineStart.toOffset(),
          (tap.position + tap.center()).toOffset(), whiteBox);
    }

    for (Explosion explosion in explosions) {
      explosion.render(canvas);
    }
  }
}
