import 'dart:ui';

import 'package:flame/gestures.dart';
import 'package:flame/src/sprite_animation.dart';
import 'package:flame/src/sprite.dart';
import 'package:flame/src/game/game_render_box.dart';
import 'package:flame/src/game/game.dart';
import 'package:flame/src/assets/images.dart';
import 'package:flame/src/assets/assets_cache.dart';
import 'package:flutter/src/rendering/object.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fort_macarthur/Game/GameScreens/screens.dart';
import 'package:fort_macarthur/Game/game_loop.dart';
import 'package:vector_math/vector_math_64.dart';

import 'mainMenu.dart';

class ScreenManager extends Game with TapDetector {
  Screen activeScreen = Screen.mainMenu;
  late MainMenu mainMenu;

  // function for loading in assets and initializing classes
  Future<void> onLoad() async {
    mainMenu = MainMenu();
  }

  // touch start
  void onTapDown(TapDownInfo event) {}

  // drag motion started
  void onPanStart(DragStartInfo details) {}

  // continued touch dragging movement
  void onPanUpdate(DragUpdateInfo details) {}

  // when the touch ends
  void onPanEnd(DragEndInfo details) {}

  // updates game
  void update(double dt) {}

  // renders objects to the canvas
  void render(Canvas canvas) {}

  @override
  VoidCallback? pauseEngineFn;

  @override
  VoidCallback? resumeEngineFn;

  @override
  late bool runOnCreation;

  @override
  void assertHasLayout() {
    // TODO: implement assertHasLayout
  }

  @override
  // TODO: implement assets
  AssetsCache get assets => throw UnimplementedError();

  @override
  void attach(PipelineOwner owner, GameRenderBox gameRenderBox) {
    // TODO: implement attach
  }

  @override
  // TODO: implement buildContext
  BuildContext? get buildContext => throw UnimplementedError();

  @override
  Vector2 convertGlobalToLocalCoordinate(Vector2 point) {
    // TODO: implement convertGlobalToLocalCoordinate
    throw UnimplementedError();
  }

  @override
  Vector2 convertLocalToGlobalCoordinate(Vector2 point) {
    // TODO: implement convertLocalToGlobalCoordinate
    throw UnimplementedError();
  }

  @override
  void detach() {
    // TODO: implement detach
  }

  @override
  // TODO: implement hasLayout
  bool get hasLayout => throw UnimplementedError();

  @override
  // TODO: implement images
  Images get images => throw UnimplementedError();

  @override
  // TODO: implement isAttached
  bool get isAttached => throw UnimplementedError();

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    // TODO: implement lifecycleStateChange
  }

  @override
  Future<Sprite> loadSprite(String path,
      {Vector2? srcSize, Vector2? srcPosition}) {
    // TODO: implement loadSprite
    throw UnimplementedError();
  }

  @override
  Future<SpriteAnimation> loadSpriteAnimation(
      String path, SpriteAnimationData data) {
    // TODO: implement loadSpriteAnimation
    throw UnimplementedError();
  }

  @override
  void onAttach() {
    // TODO: implement onAttach
  }

  @override
  void onDetach() {
    // TODO: implement onDetach
  }

  @override
  void onResize(Vector2 size) {
    // TODO: implement onResize
  }

  @override
  void onTimingsCallback(List<FrameTiming> timings) {
    // TODO: implement onTimingsCallback
  }

  @override
  // TODO: implement overlays
  ActiveOverlaysNotifier get overlays => throw UnimplementedError();

  @override
  void pauseEngine() {
    // TODO: implement pauseEngine
  }

  @override
  Vector2 projectVector(Vector2 vector) {
    // TODO: implement projectVector
    throw UnimplementedError();
  }

  @override
  void resumeEngine() {
    // TODO: implement resumeEngine
  }

  @override
  Vector2 scaleVector(Vector2 vector) {
    // TODO: implement scaleVector
    throw UnimplementedError();
  }

  @override
  // TODO: implement size
  Vector2 get size => throw UnimplementedError();

  @override
  Vector2 unprojectVector(Vector2 vector) {
    // TODO: implement unprojectVector
    throw UnimplementedError();
  }

  @override
  Vector2 unscaleVector(Vector2 vector) {
    // TODO: implement unscaleVector
    throw UnimplementedError();
  }
}
