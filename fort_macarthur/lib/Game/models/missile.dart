import 'dart:math';

import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:fort_macarthur/Game/models/enemyplane.dart';
import 'package:fort_macarthur/Game/models/sound_manager.dart';
import 'package:fort_macarthur/game/models/trail_particles.dart';

// class that handles the missile bounding box that is moving towards
// it's destination
class Missile extends PositionComponent with Hitbox, Collidable {
  Vector2 missileDirection = Vector2.zero();
  double missileSpeed;
  late TrailParticleSystem particles;
  HitboxRectangle collider = HitboxRectangle(relation: Vector2(1.0, 1.0));

  GameSoundEffect missileSound = new GameSoundEffect(
    soundPath: "assets/sounds/missileSound.wav",
  );

  bool playSoundOnce = true;
  bool touchedPlane = false;

  Missile(
      {required Vector2 givenSize,
      required Color color,
      required Vector2 position,
      double angle = 0.0,
      Color particleColor = Colors.white,
      this.missileSpeed = 300.0}) {
    particles = new TrailParticleSystem(
      parentDirection: -missileDirection,
      spawnPosition: position - (size / 2.0),
      color: particleColor,
      speed: 40,
      spawnRate: 0.005,
      fadeOutRate: 8,
      acceleration: 5,
      radius: 5,
    );

    collider.size = givenSize;
    size = givenSize;

    addShape(collider);

    collider.size = givenSize;
    collider.offsetPosition = position;
    collider.position = position;
  }

  void setPosition(Vector2 position) {
    collider.offsetPosition = position - size / 2.0;
    collider.position = collider.offsetPosition;
  }

  void playLaunchSound() {
    if (playSoundOnce) {
      missileSound.play();
      playSoundOnce = false;
    }
  }

  void resetSoundBool() {
    missileSound.stop();
    playSoundOnce = true;
  }

  Vector2 get position {
    return collider.offsetPosition;
  }

  // far from perfect
  void faceDirection(Vector2 direction) {
    collider.angle = atan2(direction.y, direction.x);
  }

  void clearParticles() {
    particles.particles.clear();
  }

  // moves the missile in it's direction
  // ignore: must_call_super
  void update(double dt) {
    super.update(dt);
    playLaunchSound();

    collider.offsetPosition.add(missileDirection * missileSpeed * dt);
    collider.position = collider.offsetPosition;
    particles.updatePosition(collider.offsetPosition + size);
    particles.updateDirection(missileDirection);
    particles.update(dt);
  }

  // draws the missile
  // ignore: must_call_super
  void render(Canvas canvas) {
    particles.render(canvas);
    collider.render(canvas, Paint()..color = Colors.white);
  }
}
