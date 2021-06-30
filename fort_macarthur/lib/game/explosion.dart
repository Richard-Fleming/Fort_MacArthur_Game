import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'game_object.dart';

class Explosion {
  late GameObjectCircle explosion;
  double initialRadius;
  double maxRadius;
  double radiusIncreaseSpeed;
  int lingerTimeInMilliseconds;
  bool alive = true;
  bool active = true;

  Explosion(
      {this.initialRadius = 10,
      this.maxRadius = 60,
      this.radiusIncreaseSpeed = 40,
      this.lingerTimeInMilliseconds = 200,
      required Vector2 position}) {
    explosion = new GameObjectCircle(
        radius: initialRadius, color: Color(0xFFFFFFFF), position: position);
  }

  void update(double dt) {
    if (active) {
      explosion.update(dt);
      explosion.updateRadius(radiusIncreaseSpeed, dt);

      if (explosion.radius > maxRadius) {
        explode();
      }
    }
  }

  void explode() async {
    active = false;
    await Future.delayed(Duration(milliseconds: lingerTimeInMilliseconds), () {
      alive = false;
    });
  }

  void render(Canvas canvas) {
    if (alive) {
      explosion.render(canvas);
    }
  }
}
