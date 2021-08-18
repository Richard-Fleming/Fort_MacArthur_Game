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
  HitboxShape collider = HitboxRectangle(relation: Vector2(1.0, 1.0));

  GameSoundEffect missileSound = new GameSoundEffect(
    soundPath: "assets/sounds/missileSound.wav",
  );

  bool playSoundOnce = true;

  Missile(
      {required Vector2 size,
      required Color color,
      required Vector2 position,
      double angle = 0.0,
      Color particleColor = Colors.white,
      this.missileSpeed = 300.0}) {
    particles = new TrailParticleSystem(
      parentDirection: -missileDirection,
      spawnPosition: position,
      color: particleColor,
      speed: 40,
      spawnRate: 0.005,
      fadeOutRate: 8,
      acceleration: 5,
      radius: 5,
    );

    collider.size = size;
    addShape(collider);
    collider.component.size = size;
    collider.offsetPosition = position;
  }

  void setPosition(Vector2 position) {
    collider.offsetPosition = position - size / 2.0;
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

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is EnemyPlane) {
      print("missile hit plane from base :)");
      other.reset();
    }
  }
}
