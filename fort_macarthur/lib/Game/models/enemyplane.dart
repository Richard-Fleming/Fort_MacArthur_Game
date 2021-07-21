import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:fort_macarthur/Game/models/missile.dart';
import 'dart:math';
import 'healthbar.dart';

class EnemyPlane extends PositionComponent with Hitbox, Collidable {
  // size of hitbox
  final double bodySize = 40.0;

  // starting points -- add more if needed
  final List<Vector2> startpoints = [];

  // the last picked starting point
  int startingpoint = 0;

  // size of the device screen
  final Vector2 screenSize;

  // Time between starting
  double timeToRespawn = 0;
  // Max time that it can take before a plane starts again
  int maxTimeBetweenRespawn = 4;

  // vector of determined end position
  Vector2 bottomPosition = Vector2.zero();

  // heading vector
  Vector2 dir = Vector2.zero();

  // speed at which plane approaches end position
  double speed = 160;

  bool initialSpawn = true;
  bool destroyed = false;

  late HealthBar healthbar;

  // plane body
  HitboxShape hitbox = HitboxRectangle(relation: Vector2(1.0, 1.0));

  EnemyPlane(this.screenSize, this.healthbar) {
    startpoints.add(Vector2(bodySize, -60.0)); // left starting point
    startpoints.add(Vector2(
        (screenSize.x / 2.0) - (bodySize / 2), -60.0)); // middle starting point
    startpoints.add(
        Vector2(screenSize.x - (bodySize * 2), -60.0)); // right starting point)

    hitbox.size = Vector2(bodySize, bodySize);
    addShape(hitbox);

    hitbox.component.size = Vector2(bodySize, bodySize);

    resetPlane();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (timeToRespawn <= 0) {
      hitbox.component.position = Vector2(
          hitbox.component.position.x + (dir.x * speed) * dt,
          hitbox.component.position.y + (dir.y * speed) * dt);
    } else
      timeToRespawn -= dt;

    if (hitbox.component.position.y > screenSize.y + hitbox.size.y) {
      resetPlane();
    }
  }

  @override
  void render(Canvas c) {
    super.render(c);
    // TODO: Remove this once a proper sprite is in order for the Enemy Plane
    hitbox.render(c, Paint()..color = Colors.red);
  }

  /// Resets Enemy Plane to a New Position
  void resetPlane() {
    // generates num between 0 and 2
    startingpoint = Random().nextInt(startpoints.length);
    hitbox.component.position = startpoints[startingpoint];

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
  }

  // Determines the line towards the end position based on the start position
  void determinePath() {
    // Use the newly determined bottom point
    // against the chosen starting point
    // in order to gauge the line towards the bottom from the start.
    dir = (bottomPosition - startpoints[startingpoint]).normalized();
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is Missile) {
      destroyed = true;
      resetPlane();
      print("missile was touched :))");
    }
  }
}
