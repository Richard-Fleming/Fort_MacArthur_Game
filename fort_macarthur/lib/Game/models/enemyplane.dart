import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'healthbar.dart';

class EnemyPlane extends PositionComponent {
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

  late HealthBar healthbar;

  // plane body
  late Rect body;

  EnemyPlane(this.screenSize, this.healthbar) {
    startpoints.add(Vector2(bodySize, -60.0)); // left starting point
    startpoints.add(Vector2(
        (screenSize.x / 2.0) - (bodySize / 2), -60.0)); // middle starting point
    startpoints.add(
        Vector2(screenSize.x - (bodySize * 2), -60.0)); // right starting point)
    resetPlane();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (timeToRespawn <= 0)
      body = body.translate((dir.x * speed) * dt, (dir.y * speed) * dt);
    else
      timeToRespawn -= dt;

    if (body.top > screenSize.y + bodySize) {
      resetPlane();
    }
  }

  @override
  void render(Canvas c) {
    super.render(c);
    c.drawRect(body, Paint()..color = Colors.red);
  }

  /// Resets Enemy Plane to a New Position
  void resetPlane() {
    // generates num between 1 and 3
    // minus 1 as arrays start at 0, so we get a range of 0 to 2.
    startingpoint = Random().nextInt(startpoints.length);
    body = Rect.fromLTWH(startpoints[startingpoint].x,
        startpoints[startingpoint].y, bodySize, bodySize);

    // Now that the plane has been set up at the top,
    // we will not determine a bottom position
    pickBottomPosition();

    // With all info required, now find the normalized path
    determinePath();

    var random = new Random(); // needed to allow access for static variables
    timeToRespawn = random.nextDouble() * maxTimeBetweenRespawn;

    if (!initialSpawn)
      healthbar.manageHealth(-2);
    else
      initialSpawn = false;
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

  void reset() {
    timeToRespawn = 0;
    resetPlane();
  }
}
