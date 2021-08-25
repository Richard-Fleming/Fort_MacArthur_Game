import 'dart:ui';

import 'package:flame/components.dart';

/// This class represents all the details required
/// to create an [Enemy] component.
class EnemyData {
  // Speed of the enemy.
  final double speed;

  // Level of this enemy.
  final int level;

  // Indicates if this enemy can move horizontally.
  final bool hMove;

  final Color color;

  final double size;

  const EnemyData(
      {required this.speed,
      required this.level,
      required this.hMove,
      required this.color,
      required this.size});
}
