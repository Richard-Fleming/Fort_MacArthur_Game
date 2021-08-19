import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:fort_macarthur/game/models/explosion.dart';
import 'package:fort_macarthur/Game/models/missile.dart';
import 'package:fort_macarthur/game/models/explosion_particles.dart';

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
  List<ExplosionParticleSystem> explosionParticles =
      []; // allows explosion particles to linger longer than the explosion hitbox

  double missileSpeed = 300;
  double explosionInitialRadius = 10;

  bool missileLaunched = false;
  bool explosionTriggered = false;
  bool explosionVisible = false;
  bool isPressed = false;
  bool wasLaunched = false;

  Paint whiteBox = new Paint()..color = Color(0xFFFFFFFF);

  // initializing all of the game objects
  MissileSystem() {
    missile = new Missile(
        size: Vector2(30, 10),
        color: Color(0xFFFFFFFF),
        position: Vector2.zero(),
        particleColor: Colors.grey.shade400);

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

    lineStart = base.position + base.getCenter();
  }

  // launches missile on tap
  void launchMissileOnTap(TapDownInfo event) {
    if (!missileLaunched) {
      isPressed = true;

      tap.setPosition(
          Vector2(event.eventPosition.game.x, event.eventPosition.game.y) -
              tap.getCenter());
      missile.setPosition(base.position + base.getCenter());

      // missile direction calculations
      missile.missileDirection = ((tap.position - missile.size / 4.0) -
              missile.position -
              missile.size / 8.0)
          .normalized();
      missile.faceDirection(missile.missileDirection);
    }
  }

  // sets up initial missile destination and line
  void setupDestination(DragStartInfo details) {
    if (!missileLaunched) {
      isPressed = true;
      tap.setPosition(
          Vector2(details.eventPosition.game.x, details.eventPosition.game.y) -
              tap.getCenter());
      missile.setPosition(base.position + base.getCenter());

      // missile direction calculations
      missile.missileDirection = ((tap.position - missile.size / 4.0) -
              missile.position -
              missile.size / 8.0)
          .normalized();
      missile.faceDirection(missile.missileDirection);
    }
  }

  // updates the missile destination and line
  void moveDestination(DragUpdateInfo details) {
    if (!missileLaunched) {
      isPressed = true;
      tap.setPosition(
          Vector2(details.eventPosition.game.x, details.eventPosition.game.y) -
              tap.getCenter());
      missile.setPosition(base.position + base.getCenter());

      // missile direction calculations
      missile.missileDirection = ((tap.position - missile.size / 4.0) -
              missile.position -
              missile.size / 8.0)
          .normalized();
      missile.faceDirection(missile.missileDirection);
    }
  }

  // launches the missile
  void launchMissile() {
    // checks if missile destination is not under the base
    if (isPressed && !missileLaunched && tap.position.y < base.position.y) {
      missileLaunched = true;
      wasLaunched = true;
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
      if (missile.position.y < tap.position.y || missile.touchedPlane) {
        explosions.add(Explosion(
          position: missile.position + missile.size / 2.0,
        ));

        // create an instance of the explosion particles
        explosionParticles.add(ExplosionParticleSystem(
          directionRange: Vector2(-1, 1),
          spawnPosition: missile.position + missile.size / 2.0,
          minSpeed: 30,
          maxSpeed: 60,
          numOfParticles: 200,
          color: Color(0xFFF76D23), // light rust orange color,
          fadeOutRate: 3,
          timeToLive: 0.2,
          minAcceleration: 1,
          maxAcceleration: 10,
          radius: 15,
        ));

        missile.setPosition(base.position + base.getCenter());
        missile.clearParticles();
        missile.resetSoundBool();
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

    for (int i = explosionParticles.length - 1; i >= 0; --i) {
      explosionParticles.elementAt(i).update(dt);
    }
  }

  // render objects to the screen when certain conditions are met
  void render(Canvas canvas) {
    if (missileLaunched) {
      missile.render(canvas);
    }

    if (isPressed || missileLaunched) {
      tap.render(canvas);
      canvas.drawLine(lineStart.toOffset(),
          (tap.position + tap.getCenter()).toOffset(), whiteBox);
    }

    for (Explosion explosion in explosions) {
      explosion.render(canvas);
    }

    for (ExplosionParticleSystem explosionParticleSystem
        in explosionParticles) {
      explosionParticleSystem.render(canvas);
    }

    base.render(canvas);
  }

  void reset() {
    for (int i = explosions.length - 1; i >= 0; --i) {
      explosions.remove(i);
    }
  }
}
