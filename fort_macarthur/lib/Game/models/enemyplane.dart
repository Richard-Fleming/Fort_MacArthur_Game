import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:fort_macarthur/Game/models/enemy_data.dart';
import 'package:fort_macarthur/Game/models/missile.dart';
import 'package:fort_macarthur/Game/models/sound_manager.dart';
import 'package:fort_macarthur/game/models/trail_particles.dart';
import 'dart:math';
import 'healthbar.dart';

class EnemyPlane extends PositionComponent with Hitbox, Collidable {
  // size of hitbox
  final double bodySize = 40.0;

  // size of the device screen
  final Vector2 screenSize;

  // Stores dynamic variables for different enemy types
  late EnemyData enemyData;

  // heading vector
  Vector2 dir = Vector2.zero();

  // vector of determined end position
  Vector2 bottomPosition = Vector2.zero();

  // position used for the particles
  Vector2 position = Vector2.zero();

  // speed at which plane approaches end position
  double speed = 160;

  bool destroyed = false;

  bool initialSpawn = true;

  // Time between starting
  double timeToRespawn = 0;
  // Max time that it can take before a plane starts again
  int maxTimeBetweenRespawn = 4;

  late HealthBar healthbar;

  GameSoundEffect planeSound = new GameSoundEffect(
    soundPath: "assets/sounds/planeSound.wav",
    loop: true,
    volume: 0.8,
  );

  // the last picked starting point
  int startingpoint = 0;

  bool playSoundOnce = true;

  // plane body
  HitboxShape hitbox = HitboxRectangle(relation: Vector2(1.0, 1.0));

  late TrailParticleSystem particles;

  // starting points -- add more if needed
  final List<Vector2> spawnPos;

  EnemyPlane(
    this.screenSize,
    this.healthbar,
    this.spawnPos, {
    required this.enemyData,
  }) {
    size = Vector2(bodySize, bodySize);
    hitbox.size = Vector2(bodySize, bodySize);
    hitbox.offsetPosition = spawnPos[0];

    addShape(hitbox);

    hitbox.size = Vector2(bodySize, bodySize);
    hitbox.offsetPosition = spawnPos[0];
    hitbox.position = spawnPos[0];

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

    if (timeToRespawn <= 0) {
      hitbox.offsetPosition.add(dir * speed * dt);
      hitbox.component.position = hitbox.offsetPosition;
      position = hitbox.offsetPosition;
      planeSound.play();
    } else
      timeToRespawn -= dt;

    if (hitbox.position.y > screenSize.y + hitbox.size.y) {
      planeSound.stop();
      resetPlane();
    }

    particles.updatePosition(position + Vector2.all(bodySize / 2));
    particles.updateDirection(-dir);
    particles.update(dt);
  }

  @override
  void render(Canvas c) {
    super.render(c);
    // TODO: Remove this once a proper sprite is in order for the Enemy Plane
    hitbox.render(c, Paint()..color = enemyData.color);

    particles.render(c);
  }

  /// Resets Enemy Plane to a New Position
  void resetPlane() {
    // generates num between 0 and 2
    startingpoint = Random().nextInt(spawnPos.length);
    hitbox.offsetPosition = spawnPos[startingpoint];

    position = Vector2(spawnPos[startingpoint].x, spawnPos[startingpoint].y);
    hitbox.offsetPosition = spawnPos[0];

    position = hitbox.offsetPosition;

    // Now that the plane has been set up at the top,
    // we will now determine a bottom position
    pickBottomPosition();

    // With all info required, now find the normalized path
    determinePath();

    var random = new Random(); // needed to allow access for static variables
    timeToRespawn = random.nextDouble() * maxTimeBetweenRespawn;

    // only damage the health bar if the plane was not destroyed on this reset
    // and it isn't the plane's first time spawning in
    if (!initialSpawn && !destroyed)
      healthbar.manageHealth(-2);
    else if (initialSpawn) {
      initialSpawn = false;
    }
  }

  // Determine the position at the bottom of the screeen
  // on X for the plane to move towards
  // Y is always the same value, so it does not need to be determined.
  void pickBottomPosition() {
    double newPos = Random().nextDouble() * screenSize.x;

    if (newPos < screenSize.x / 2) {
      newPos += bodySize / 2;
    } else if (newPos > screenSize.x / 2) {
      newPos -= bodySize / 2;
    }

    bottomPosition = new Vector2(newPos, screenSize.y);
    print(
        "Bottom of where the movement vector is: " + bottomPosition.toString());
  }

  // Determines the line towards the end position based on the start position
  void determinePath() {
    // Use the newly determined bottom point
    // against the chosen starting point
    // in order to gauge the line towards the bottom from the start.
    dir = (bottomPosition - spawnPos[startingpoint]).normalized();
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is Missile) {
      destroyed = true;
      resetPlane();
      print("missile was touched :))");
    }
  }

  void reset() {
    initialSpawn = true;
    resetPlane();
    print("Plane reset");
  }

  void stopSound() {
    planeSound.stop();
  }

  Vector2 getPosition() {
    return hitbox.position;
  }
}
