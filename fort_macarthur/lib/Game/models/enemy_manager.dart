import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:fort_macarthur/Game/game/game_loop.dart';
import 'package:fort_macarthur/Game/game/knows_game_size.dart';
import 'package:fort_macarthur/Game/models/enemy_data.dart';
import 'package:fort_macarthur/Game/models/enemyplane.dart';
import 'package:fort_macarthur/Game/models/healthbar.dart';

class EnemyManager extends BaseComponent
    with KnowsGameSize, HasGameRef<GameLoop> {
  // The timer which runs the enemy spawner code at regular interval of time.
  late Timer _timer;

  // Controls for how long EnemyManager should stop spawning new enemies.
  late Timer _freezeTimer;

  final Vector2 initialSize = Vector2(64, 64);

  late HealthBar healthbar;

  late EnemyPlane enemy;

  // Holds an object of Random class to generate random numbers.
  Random random = Random();

  EnemyManager(this.healthbar) : super() {
    // Sets the timer to call _spawnEnemy() after every 3 seconds, until timer is explicitly stopped.
    _timer = Timer(3, callback: _spawnEnemy, repeat: true);

    // Sets freeze time to 5 seconds. After 2 seconds spawn timer will start again.
    _freezeTimer = Timer(5, callback: () {
      _timer.start();
    });
  }
  // Spawns a new enemy at random position at the top of the screen.
  void _spawnEnemy() {
    // Make sure that we have a valid BuildContext before using it.
    if (gameRef.buildContext != null) {
      /// Gets a random [EnemyData] object from the list.
      final enemyData = _enemyDataList.elementAt(random.nextInt(1));

      enemy = EnemyPlane(gameSize, healthbar, enemyData: enemyData);

      // Makes sure that the enemy sprite is centered.
      enemy.anchor = Anchor.center;

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
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);

    enemy.render(canvas);
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
  }

  // Pauses spawn timer for 2 seconds when called.
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
