import 'dart:math';

import 'dart:ui';

import 'package:flame/components.dart';
import 'package:fort_macarthur/Game/game/game_loop.dart';
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

  int enemyCount = 3;

  List<EnemyPlane> _listOfEnemies = [];

  final Vector2 initialSize = Vector2(40.0, 40.0);

  late HealthBar healthbar;

  late EnemyPlane enemy;

  // size of the device screen
  final Vector2 screenSize;

  // Holds an object of Random class to generate random numbers.
  Random random = Random();

  EnemyManager(this.screenSize, this.healthbar) : super() {
    // Sets the timer to call _spawnEnemy() after every 1 second, until timer is explicitly stops.
    _timer = Timer(1, callback: _spawnEnemy, repeat: true);

    // Sets freeze time to 2 seconds. After 2 seconds spawn timer will start again.
    _freezeTimer = Timer(2, callback: () {
      _timer.start();
    });
  }

  void _spawnEnemy() {
    // Make sure that we have a valid BuildContext before using it.
    if (gameRef.buildContext != null) {
      enemy = EnemyPlane(screenSize, healthbar);

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

    _timer.update(dt);
    _freezeTimer.update(dt);
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

  void reset() {
    _timer.stop();
    _timer.start();
  }

  // Pauses spawn timer for 2 seconds when called.
  void freeze() {
    _timer.stop();
    _freezeTimer.stop();
    _freezeTimer.start();
  }
}
