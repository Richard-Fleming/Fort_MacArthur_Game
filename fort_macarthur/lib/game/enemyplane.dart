import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class EnemyPlane extends PositionComponent {
  final double offset = 25.0;

  final List<Vector2> startpoints = [];

  final int startingpoint = 0;

  var body = new Rect.fromLTWH(0, 0, 25, 25);

  EnemyPlane() {
    startpoints.add(Vector2((offset / 2.0), -60.0)); // left starting point
    startpoints
        .add(Vector2(200 - (offset / 2), -60.0)); // middle starting point
    startpoints
        .add(Vector2(375 - (offset / 2), -60.0)); // right starting point)

    resetPlane();
  }

  @override
  void update(double dt) {
    super.update(dt);

// TODO: Adjust this value later, as it is only used for debugging purposes
    body = body.translate(0, 3);

    if (body.top > 625) {
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
    int pos = Random().nextInt(startpoints.length);

    print(pos); // FIXME: Remove this print!

    body = Rect.fromLTWH(startpoints[pos].x, startpoints[pos].y, 40, 40);
  }
}
