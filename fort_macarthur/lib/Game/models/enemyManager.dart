import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:fort_macarthur/Game/game/game_loop.dart';
import 'package:fort_macarthur/Game/models/enemy_data.dart';
import 'package:fort_macarthur/Game/models/enemyplane.dart';
import 'package:fort_macarthur/Game/models/healthbar.dart';

class EnemyManager extends BaseComponent with HasGameRef<GameLoop> {
  // The timer which runs the enemy spawner code at regular interval of time.
  late Timer _timer;

  // Controls for how long EnemyManager should stop spawning new enemies.
  late Timer _freezeTimer;

  // starting points -- add more if needed
  final List<Vector2> startpoints = [];

  // the last picked starting point
  int startingpoint = 0;

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
    // Sets the timer to call _spawnEnemy() after every 3 seconds, until timer is explicitly stopped.
    _timer = Timer(3, callback: _spawnEnemy, repeat: true);

    // Sets freeze time to 5 seconds.
    _freezeTimer = Timer(5, callback: reset, repeat: spawnEnemies);

    startpoints.add(Vector2.zero()); // left starting point
    startpoints.add(Vector2.zero()); // middle starting point
    startpoints.add(Vector2.zero()); // right Start Point
  }

  void _spawnEnemy() {
    // Make sure that we have a valid BuildContext before using it.
    if (gameRef.buildContext != null) {
      /// Gets a random [EnemyData] object from the list.
      final enemyData =
          _enemyDataList.elementAt(random.nextInt(_enemyDataList.length));

      if (startpoints[0] == Vector2.zero()) {
        startpoints[0] = Vector2(enemyData.size, -60.0);
        startpoints[1] =
            Vector2((screenSize.x / 2.0) - (enemyData.size / 2), -60.0);
        startpoints[2] = Vector2(screenSize.x - (enemyData.size * 2), -60.0);
      }

      Vector2 spawn = startpoints[random.nextInt(startpoints.length)];
      enemy = EnemyPlane(screenSize, healthbar, spawn, enemyData: enemyData);

      _listOfEnemies.add(enemy);

      if (_listOfEnemies.length == 3) {
        _timer.stop();
      }

      if (enemy.getPosition().y < 0) enemy.resetPlane();

      // Add it to components list of game instance, instead of EnemyManager.
      // This ensures the collision detection working correctly.
      gameRef.add(enemy);
    }
  }

  @override
  void onMount() {
    super.onMount();
    // Start the timer as soon as current enemy manager get prepared
    // and added to the game instance.
    _timer.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    // Stop the timer if current enemy manager is getting removed from the
    // game instance.
    _timer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update timers with delta time to make them tick.
    _timer.update(dt);
    _freezeTimer.update(dt);
  }

  // Stops and restarts the timer. Should be called
  // while restarting and exiting the game.
  void reset() {
    _timer.stop();
    _timer.start();

    // generates num between 0 and 2
    startingpoint = Random().nextInt(startpoints.length);
  }

  void freeze() {
    _timer.stop();
    _freezeTimer.stop();
    _freezeTimer.start();
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
      size: 50.0,
    ),
  ];
}
