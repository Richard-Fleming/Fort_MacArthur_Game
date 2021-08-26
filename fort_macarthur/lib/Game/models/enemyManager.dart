import 'dart:math';

import 'dart:ui';

import 'package:flame/components.dart';

import 'package:flame/gestures.dart';
import 'package:fort_macarthur/Game/game/game_loop.dart';
import 'package:fort_macarthur/Game/models/enemy_data.dart';
import 'package:fort_macarthur/Game/models/enemyplane.dart';
import 'package:fort_macarthur/Game/models/healthbar.dart';

class EnemyManager extends BaseComponent with HasGameRef<GameLoop> {
  Vector2 spawn = Vector2.zero();

  // starting points -- add more if needed
  final List<Vector2> startpoints = [];

  // the last picked starting point
  int startingpoint = 0;

  int enemyCount = 3;

  List<EnemyPlane> _listOfEnemies = [];

  final Vector2 initialSize = Vector2(64, 64);

  late HealthBar healthbar;

  final bool spawnEnemies = true;

  late EnemyPlane enemy;

  late EnemyData enemyData;

  // size of the device screen
  final Vector2 screenSize;

  // Holds an object of Random class to generate random numbers.
  Random random = Random();

  EnemyManager(this.screenSize, this.healthbar) : super() {
    startpoints.add(Vector2.zero()); // left starting point
    startpoints.add(Vector2.zero()); // middle starting point
    startpoints.add(Vector2.zero()); // right Start Point
  }

  void _spawnEnemy() {
    Vector2 position = Vector2(random.nextDouble() * screenSize.x, 0);
    Vector2 initialSize = Vector2(40, 40);

    position.clamp(
        Vector2.zero() + initialSize / 2, screenSize - initialSize / 2);
    // Make sure that we have a valid BuildContext before using it.
    if (gameRef.buildContext != null) {
      /// Gets a random [EnemyData] object from the list.
      final enemyData =
          _enemyDataList.elementAt(random.nextInt(_enemyDataList.length));

      enemy =
          EnemyPlane(screenSize, healthbar, startpoints, enemyData: enemyData);

      enemy.anchor = Anchor.center;

      _listOfEnemies.add(enemy);

      // Add it to components list of game instance, instead of EnemyManager.
      // This ensures the collision detection working correctly.
      addChild(enemy);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_listOfEnemies.length <= 2) {
      _spawnEnemy();
    }
  }

  void reset() {
    for (int i = 0; i < enemyCount; i++) {
      enemy.stopSound();
      enemy.remove();
    }
  }

  /// A private list of all [EnemyData]s.
  static const List<EnemyData> _enemyDataList = [
    EnemyData(
      speed: 150,
      level: 1,
      hMove: false,
      color: Color.fromARGB(255, 255, 255, 255),
      size: 40.0,
    ),
    EnemyData(
      speed: 250,
      level: 4,
      hMove: false,
      color: Color.fromARGB(255, 00, 00, 00),
      size: 40.0,
    ),
  ];
}
