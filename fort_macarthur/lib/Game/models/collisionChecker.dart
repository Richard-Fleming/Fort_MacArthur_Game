import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:fort_macarthur/Game/models/missile.dart';
import 'package:fort_macarthur/Game/models/sound_manager.dart';
import 'package:fort_macarthur/game/models/trail_particles.dart';
import 'dart:math';
import 'healthbar.dart';

class Collider {
  Collider();
  List<PositionComponent> collidables = [];

  void addObjectToCheck(PositionComponent object) {
    collidables.add(object);
  }

  void update(double dt) {
    if (collidables.length > 1) {
      // make sure there's at least 2 collidables to check
      for (int i = 0; i < collidables.length; i++) {
        for (int n = 0; n < collidables.length; n++) {
          if (n == i)
            continue; // don't check against self
          else {
            // do collision code here
          }
        }
      }
    }
  }

  void render(Canvas c) {
    // this function isn't necessarily needed,
    // but can be useful for debugging purposes
  }
}
