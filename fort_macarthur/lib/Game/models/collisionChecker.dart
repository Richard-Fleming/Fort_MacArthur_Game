import 'dart:ui';
import 'package:flutter/material.dart';
import 'enemyplane.dart';
import 'missile.dart';

class Collider {
  Collider();
  List<EnemyPlane> collidables = [];

  late Missile collMissile;

  void addObjectToCheck(EnemyPlane object) {
    collidables.add(object);
  }

  void addMissile(Missile miss) {
    collMissile = miss;
  }

  void update(double dt) {
    if (collidables.length > 0) {
      // make sure there's at least 1 collidable to check
      for (int i = 0; i < collidables.length; i++) {
        // do collision code here
        // -----------------------
        // d0 = B.max.x < A.min.x;
        bool d0 = collMissile.position.x + collMissile.size.x <
            collidables[i].position.x - collidables[i].size.x;
        // d1 = A.max.x < B.min.x;
        bool d1 = collidables[i].position.x + collidables[i].size.x <
            collMissile.position.x - collMissile.size.x;
        // d2 = B.max.y < A.min.y;
        bool d2 = collMissile.position.y + collMissile.size.y <
            collidables[i].position.y - collidables[i].size.y;
        // d3 = A.max.y < B.min.y;
        bool d3 = collidables[i].position.y + collidables[i].size.y <
            collMissile.position.y - collMissile.size.y;
        // -----------------------
        if (!(d0 | d1 | d2 | d3)) {
          collidables[i].destroyed = true;
          collidables[i].reset();
          collMissile.touchedPlane = true;
          break; // only do one collision at a time, don't bother checking all
        }
      }
    }
  }

  void render(Canvas c) {
    // this function isn't necessarily needed,
    // but can be useful for debugging purposes
  }
}
