import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class HealthBar extends PositionComponent {
  static const int MAX_OPAQUE = 255;

  static const maxHealth = 10.0;
  static const int fadeRate = 10;
  static double health = 10.0;
  static int currentFade = 255;

  late Paint barColor;
  late Paint bgColor;
  final double left;
  final double top;

  bool fade = false;
  bool dead = false;

  HealthBar(this.left, this.top) {
    // bar color starts out opaque
    applyPaint();
  }

  void applyPaint() {
    barColor = Paint()..color = Color.fromARGB(currentFade, 255, 0, 0);
    bgColor = Paint()..color = Color.fromARGB(currentFade, 200, 200, 200);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (fade) {
      fadeIn();
    } else {
      fadeOut();
    }

    if (getHealth() <= 0.0) {
      print("Health value:" + health.toString());
      dead = true;
      health = maxHealth;
    }
  }

  @override
  void render(Canvas c) {
    super.render(c);
    c.drawRect(
        Rect.fromLTWH(left - 10, top - 7.5, maxHealth * 12, 50), bgColor);
    c.drawRect(Rect.fromLTWH(left, top, health * 10, 35), barColor);
  }

  void setFade(bool isFading) {
    fade = isFading;
  }

  /// Adjust Health based on amount passed in.
  /// If health goes over the limit on either side,
  /// it will be reset to the limit.
  /// @amount Amount to adjust health by
  void manageHealth(int amount) {
    health += amount;

    if (health > maxHealth)
      health = maxHealth;
    else if (health < 0) health = 0;
  }

  void fadeIn() {
    if (currentFade < MAX_OPAQUE) {
      currentFade += fadeRate;
      if (currentFade > MAX_OPAQUE) currentFade = MAX_OPAQUE;

      applyPaint();
    }
  }

  void fadeOut() {
    if (currentFade > 0) {
      currentFade -= fadeRate;
      if (currentFade < 0) currentFade = 0;

      applyPaint();
    }
  }

  double getHealth() {
    return health;
  }
}
