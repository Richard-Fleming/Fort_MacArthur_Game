import 'dart:html';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class EnemyPlane extends PositionComponent {
  final List<Vector2> startpoints = [
    Vector2(100.0, 25.0), // left starting point
    Vector2(300.0, 25.0), // middle starting point
    Vector2(500.0, 25.0), // right starting point
  ];

  final int startingpoint = 0;

  var body = new Rect.fromLTWH(0, 0, 100, 100);

  EnemyPlane();

  @override
  void update(double dt) {
    super.update(dt);

// TODO: Adjust this value later, as it is only used for debugging purposes
    body.translate(0, 3);

    if (body.top > 800) {
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
    int pos = Random().nextInt(startpoints.length) - 1;

    print(pos); // FIXME: Remove this print!

    body = Rect.fromLTWH(startpoints[pos].x, startpoints[pos].y, 100, 100);
  }
}
