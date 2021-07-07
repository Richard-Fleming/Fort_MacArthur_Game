import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'dart:ui' as ui;

class StartButton extends SpriteAnimationComponent with Hitbox, Collidable {
  StartButton({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  StartButton.fromFrameData(
    ui.Image image,
    SpriteAnimationData data, {
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size) {
    animation = SpriteAnimation.fromFrameData(image, data);
    // debugMode = true;
    addShape(HitboxRectangle());
  }
}
