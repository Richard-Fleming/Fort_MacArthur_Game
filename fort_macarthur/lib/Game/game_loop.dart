import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';

// main game loop. pan detector necessary for touch detection
abstract class GameLoop extends BaseGame with PanDetector {
  void render(Canvas canvas);

  void update(double t);

  void onTapDown(TapDownInfo event);
}
