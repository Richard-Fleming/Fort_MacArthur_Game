import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';

// main game loop. pan detector necessary for touch detection
class GameLoop extends BaseGame with PanDetector {
  // function for loading in assets and initializing classes
  Future<void> onLoad() async {
    // put image loading, class initialization here
  }

  // updates game
  void update(double dt) {
    super.update(dt);
    // put anything to be updated such here
  }

  // renders objects to the canvas
  void render(Canvas canvas) {
    super.render(canvas);
    // put anything to be drawn here
  }

  // changes the background color
  Color backgroundColor() =>
      const Color(0xFF666666); // change this to RGB if you want
}
