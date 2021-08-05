import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:fort_macarthur/Game/game/knowsGameSize.dart';
import 'package:fort_macarthur/Game/models/enemy_data.dart';
import 'package:fort_macarthur/game/models/trail_particles.dart';
import 'healthbar.dart';

class EnemyPlane extends PositionComponent with KnowsGameSize {
  // speed at which plane approaches end position
  final double speed = 160;

  // size of hitbox
  final double bodySize = 40.0;

  // The data required to create this enemy.
  /* final EnemyData enemyData; */

  // heading vector
  Vector2 dir = Vector2.zero();

  // position used for the particles
  Vector2 position = Vector2.zero();

  bool initialSpawn = true;

  // Holds an object of Random class to generate random numbers.
  Random _random = Random();

  // Represents health of this enemy.
  int _hitPoints = 5;

  late HealthBar healthbar;

  // Controls for how long enemy should be freezed.
  late Timer _freezeTimer;

  // plane body
  late Rect body;

  late TrailParticleSystem particles;

  EnemyPlane({
    /* required this.enemyData, */
    required Vector2? enemyPos,
  }) {
    resetPlane();
    particles = new TrailParticleSystem(
      parentDirection: -dir,
      spawnPosition: position,
      color: Colors.amber[600]!,
      speed: 20,
      spawnRate: 0.005,
      fadeOutRate: 4,
      acceleration: 5,
      radius: 10,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    body = body.translate((dir.x * speed) * dt, (dir.y * speed) * dt);
    position.add(Vector2((dir.x * speed) * dt, (dir.y * speed) * dt));

    particles.updatePosition(position + Vector2.all(bodySize / 2));
    particles.updateDirection(-dir);
    particles.update(dt);
  }

  @override
  void render(Canvas c) {
    super.render(c);
    particles.render(c);
    c.drawRect(body, Paint()..color = Colors.red);
  }

  /// Resets Enemy Plane to a New Position
  void resetPlane() {
    if (!initialSpawn)
      healthbar.manageHealth(-2);
    else
      initialSpawn = false;
  }
}
