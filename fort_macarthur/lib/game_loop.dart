import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'healthbar.dart';

// main game loop. pan detector necessary for touch detection
class GameLoop extends BaseGame with PanDetector, TapDetector {
  // function for loading in assets and initializing classes
  bool isPressed = false;
  var healthbar = new HealthBar(100, 100);

  Future<void> onLoad() async {
    // put image loading, class initialization here
  }

  void onTapDown(TapDownInfo event) {
    isPressed = true;
    healthbar.setFade(isPressed);
  }

  void onTapUp(TapUpInfo event) {
    isPressed = false;
    healthbar.setFade(isPressed);
  }

  void onTapCancel() {
    isPressed = false;
    healthbar.setFade(isPressed);
  }

  // updates game
  void update(double dt) {
    super.update(dt);
    healthbar.update(dt);
    // put anything to be updated such here
  }

  // renders objects to the canvas
  void render(Canvas canvas) {
    super.render(canvas);
    // put anything to be drawn here
    healthbar.render(canvas);
  }

  // changes the background color
  Color backgroundColor() =>
      const Color(0xFF666666); // change this to RGB if you want
}
