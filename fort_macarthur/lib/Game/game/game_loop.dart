import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fort_macarthur/game/models/explosion_particles.dart';
import 'package:fort_macarthur/game/models/trail_particles.dart';
import 'package:fort_macarthur/game/utilities/random_range.dart';
import '../models/ammo.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame/components.dart'; // Needed for Anchor class
import '../models/healthbar.dart';
import '../models/enemyplane.dart';
import '../models/missile_system.dart';

// main game loop. pan detector necessary for touch detection
class GameLoop extends BaseGame with PanDetector, TapDetector {
  MissileSystem missileSystem = new MissileSystem();

  int enemyCount = 3;

  bool isPressed = false;
  bool isAlreadyLoaded = false;
  late HealthBar healthbar;

  var ammoManager = new AmmunitionManager();

  TextPaint textPaint = TextPaint(
      config: TextPaintConfig(
    fontSize: 20.0,
    fontFamily: 'Awesome Font',
  ));

  bool paused = false;

  // List<CustomParticle> test = [];
  late ExplosionParticleSystem ex;
  double testSpeed = 10;

  // function for loading in assets and initializing classes
  Future<void> onLoad() async {
    // Check as if navigating between menuand gameplay it will be called multiple times
    if (!isAlreadyLoaded) {
      // put image loading, class initialization here
      healthbar = HealthBar(size.x / 1.5, size.y - 50);
      add(healthbar);

      for (var i = 0; i < enemyCount; i++) {
        add(EnemyPlane(size, healthbar));
      }
      missileSystem.baseInit(size);
    }

    ex = new ExplosionParticleSystem(
      directionRange: Vector2(-1, 1),
      spawnPosition: Vector2.all(200),
      speed: testSpeed,
      numOfParticles: 200,
      timeToLive: 10,
    );

    // for (var i = 0; i < 200; ++i) {
    //   test.add(new CustomParticle(
    //     color: Color.fromARGB(
    //       255,
    //       intInRange(1, 255),
    //       intInRange(1, 255),
    //       intInRange(1, 255),
    //     ),
    //     position: Vector2.all(200),
    //     speed: Vector2(
    //         doubleInRange(-1, 1) * testSpeed, doubleInRange(-1, 1) * testSpeed),
    //     timeToLive: 10,
    //   ));
    // }
  }

  // touch start
  void onTapDown(TapDownInfo event) {
    isPressed = true;
    healthbar.setFade(isPressed);
    ammoManager.onTapDown(event);
    missileSystem.launchMissileOnTap(event);
  }

  // touch end
  void onTapUp(TapUpInfo event) {
    isPressed = false;
    healthbar.setFade(isPressed);
    missileSystem.launchMissile();
  }

  // touch cancelled
  void onTapCancel() {
    isPressed = false;
    healthbar.setFade(isPressed);
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
    missileSystem.launchMissile();
  }

  //Resets game when navigating between menu and game screens for example
  void reset() {
    missileSystem.reset();
    components.whereType<EnemyPlane>().forEach((enemyPlane) {
      enemyPlane.remove();
    });
  }

  // updates game
  void update(double dt) {
    super.update(dt);
    missileSystem.update(dt);
    healthbar.update(dt);

    ex.update(dt);
    // for (var t in test) {
    //   t.update(dt);
    // }
    // particles.update(dt);

    // put anything to be updated such here
  }

  // renders objects to the canvas
  void render(Canvas canvas) {
    super.render(canvas);
    missileSystem.render(canvas);
    ammoManager.draw(canvas);
    healthbar.render(canvas);

    ex.render(canvas);
    // for (var t in test) {
    //   t.render(canvas);
    // }

    //TODO: Remove this when proper Enemy Manager is implemented.

    textPaint.render(
        canvas, enemyCount.toString() + ' Enemies Remain', Vector2(95, 10),
        anchor: Anchor.topCenter);
  }

  // changes the background color
  Color backgroundColor() => const Color(0xFF666666);
}
