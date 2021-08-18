import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:fort_macarthur/Game/models/sound_manager.dart';

import 'game_object.dart';

// class that handles the explosion bounding box that is spawned once a missile
// reaches it's destination
class Explosion {
  late GameObjectCircle explosion;

  double initialRadius;
  double maxRadius;
  double radiusIncreaseSpeed;
  int lingerTimeInMilliseconds;
  bool alive = true; // determines whether to draw the explosion
  bool active = true; // determines whether to update the explosion

  GameSoundEffect explosionSound = new GameSoundEffect(
    soundPath: "assets/sounds/explosionSound.wav",
  );

  bool playSoundOnce = true;

  Explosion(
      {this.initialRadius = 10,
      this.maxRadius = 60,
      this.radiusIncreaseSpeed = 40,
      this.lingerTimeInMilliseconds = 200,
      required Vector2 position}) {
    explosion = new GameObjectCircle(
        radius: initialRadius, color: Color(0xFFFFFFFF), position: position);
  }

  void reset() {
    alive = false;
    active = false;
  }

  // increases the explosion radius until max is reached as long as it's
  // active
  void update(double dt) {
    if (active) {
      playSound();
      explosion.update(dt);
      explosion.updateRadius(radiusIncreaseSpeed, dt);

      if (explosion.radius > maxRadius) {
        explode();
      }
    }
  }

  // stops updating the explosion and stops drawing the explosion after some time.
  // lingering effect
  void explode() async {
    active = false;
    await Future.delayed(Duration(milliseconds: lingerTimeInMilliseconds), () {
      alive = false;
      explosionSound.dispose();
    });
  }

  void playSound() {
    if (playSoundOnce) {
      explosionSound.play();
      playSoundOnce = false;
    }
  }

  // draws the explosion as long as it's alive
  void render(Canvas canvas) {
    if (alive) {
      explosion.render(canvas);
    }
  }
}
