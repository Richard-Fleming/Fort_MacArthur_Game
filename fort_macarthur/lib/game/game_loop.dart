import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:fort_macarthur/game/game_object.dart';
import 'missile_system.dart';

// main game loop. pan detector necessary for touch detection
class GameLoop extends BaseGame with PanDetector {
  MissileSystem missileSystem = new MissileSystem();
  // Paint paint = new Paint()..color = Color.fromARGB(255, 255, 255, 255);
  // RectTest rect = new RectTest();
  // late Rectangle a;
  // late Rectangle b;
  // late RectTest b;
  // late GameObjectRect c;
  // late GameObjectRect d;

  // Rectangle rect =
  //     Rectangle(position: Vector2(100, 100), size: Vector2(20, 20), angle: 1);

  // function for loading in assets and initializing classes
  Future<void> onLoad() async {
    missileSystem.baseInit(size);
    // a = new RectTest(position: Vector2(0, 0));
    // a = new Rectangle(
    //     position: Vector2(100, 100), size: Vector2.all(10), angle: 0.0);
    // b = new Rectangle(
    //     position: Vector2(100, 100), size: Vector2.all(10), angle: 0.0);
    // b = new RectTest(position: Vector2(0, 20));
    // a.offsetPosition = Vector2.all(10);
    // b.offsetPosition = Vector2(0, 30);
    // c = new GameObjectRect(
    //     size: Vector2(10, 10), color: paint.color, position: Vector2(0, 40));

    // d = new GameObjectRect(
    //     size: Vector2(10, 10), color: paint.color, position: Vector2(0, 60));
  }

  // touch start
  void onTapDown(TapDownInfo event) {
    missileSystem.launchMissileOnTap(event);
  }

  // drag motion started
  void onPanStart(DragStartInfo details) {
    missileSystem.setupDestination(details);
  }

  // continued touch dragging movement
  void onPanUpdate(DragUpdateInfo details) {
    missileSystem.moveDestination(details);
  }

  // when the touch ends
  void onPanEnd(DragEndInfo details) {
    missileSystem.launchMissile(details);
  }

  // updates game
  void update(double dt) {
    super.update(dt);
    missileSystem.update(dt);
    // a.update(dt);
    // b.update(dt);
    // c.update(dt);
    // d.update(dt);
    // rect.position.add(Vector2(1, 0));
    // rect.position.add(Vector2(1, 0));
    // rect.angle += 10;
    // a.position.add(Vector2(1, 1));
    // a.x += 1;
    // a.setPosition(Vector2(1, 1));
    // b.position.add(Vector2(-1, -1));

    // rect.update(dt);
    // a.angle += 0.01;
    // a.offsetPosition.x += 0.1;
  }

  // renders objects to the canvas
  void render(Canvas canvas) {
    super.render(canvas);
    missileSystem.render(canvas);
    // canvas.drawRect(rect.toRect(), paint);
    // rect.render(canvas);
    // a.render(canvas);
    // a.render(canvas, paint);
    // b.render(canvas, paint);
    // b.render(canvas);
    // c.render(canvas);
    // d.render(canvas);
  }

  // changes the background color
  Color backgroundColor() => const Color(0xFF666666);
}

// class RectTest extends PositionComponent {
//   Paint paint = new Paint()..color = Color.fromARGB(255, 255, 255, 255);
//   RectTest({Vector2? position})
//       : super(
//             position: position!, size: Vector2(20, 20), anchor: Anchor.topLeft);

//   void update(double dt) {
//     super.update(dt);
//     x += 2;
//   }

//   void render(Canvas canvas) {
//     super.render(canvas);
//     canvas.drawRect(size.toRect(), paint);
//   }
// }
