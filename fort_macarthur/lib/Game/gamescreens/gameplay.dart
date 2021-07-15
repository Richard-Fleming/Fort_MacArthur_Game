import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:fort_macarthur/Game/game/game_loop.dart';
import 'package:fort_macarthur/Game/pausebutton.dart';

import '../pausemenu.dart';

// Creating this as a file private object so as to
// avoid unwanted rebuilds of the whole game object.
GameLoop _missileGame = GameLoop();

// This class represents the actual game screen
// where all the action happens.
class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // WillPopScope provides us a way to decide if
      // this widget should be popped or not when user
      // presses the back button.

      body: WillPopScope(
        onWillPop: () async => false,
        // GameWidget is useful to inject the underlying
        // widget of any class extending from Flame's Game class.
        child: GameWidget(
          game: _missileGame,
          initialActiveOverlays: [PauseButton.ID],
          overlayBuilderMap: {
            PauseButton.ID: (BuildContext context, GameLoop gameRef) =>
                PauseButton(
                  gameRef: gameRef,
                ),
            PauseMenu.ID: (BuildContext context, GameLoop gameRef) => PauseMenu(
                  gameRef: gameRef,
                ),
          },
        ),
      ),
    );
  }
}
