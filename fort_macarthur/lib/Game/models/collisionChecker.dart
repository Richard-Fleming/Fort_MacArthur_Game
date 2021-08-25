import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math';

enum CollType { Missile, Plane }

class Collider {
  Collider();
  List<PositionComponent> collidables = [];
  List<CollType> collisionTypes = [];

  void addObjectToCheck(PositionComponent object, CollType collType) {
    collidables.add(object);
    collisionTypes.add(collType);
  }

  void update(double dt) {
    if (collidables.length > 1) {
      // make sure there's at least 2 collidables to check
      for (int i = 0; i < collidables.length; i++) {
        // don't bother checking enemy planes for collisions, only check missiles
        if (collisionTypes[i] != CollType.Missile) continue;
        for (int n = 0; n < collidables.length; n++) {
          if (n == i)
            continue; // don't check against self
          else {
            // do collision code here
            // -----------------------
            // d0 = B.max.x < A.min.x;
            bool d0 = collidables[n].position.x + collidables[n].size.x <
                collidables[i].position.x - collidables[i].size.x;
            // d1 = A.max.x < B.min.x;
            bool d1 = collidables[i].position.x + collidables[i].size.x <
                collidables[n].position.x - collidables[n].size.x;
            // d2 = B.max.y < A.min.y;
            bool d2 = collidables[n].position.y + collidables[n].size.y <
                collidables[i].position.y - collidables[i].size.y;
            // d3 = A.max.y < B.min.y;
            bool d3 = collidables[i].position.y + collidables[i].size.y <
                collidables[n].position.y - collidables[n].size.y;
            // -----------------------
            if (!(d0 | d1 | d2 | d3)) {
              print("object " +
                  i.toString() +
                  " of type " +
                  collisionTypes[i].toString() +
                  " and object " +
                  n.toString() +
                  " of type " +
                  collisionTypes[n].toString() +
                  " collided");
            }
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
