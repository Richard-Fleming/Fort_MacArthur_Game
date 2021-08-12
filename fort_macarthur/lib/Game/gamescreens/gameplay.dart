import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:fort_macarthur/Game/game/game_loop.dart';
import 'package:fort_macarthur/Game/overlays/pausebutton.dart';
import '../overlays/pausemenu.dart';
import '../overlays/game_over_menu.dart';

// Calls the gameloop which handles gameplay related code.

// Creating this as a file private object so as to
// avoid unwanted rebuilds of the whole game object.
GameLoop _missileGame = GameLoop();

// This class represents the actual game screen
// where all the action happens.
class GamePlay extends StatelessWidget {
  final bool enteredFromGame;

  const GamePlay({Key? key, required this.enteredFromGame}) : super(key: key);

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
            GameOverMenu.ID: (BuildContext context, GameLoop gameRef) =>
                GameOverMenu(
                  gameRef: gameRef,
                  enteredFromGame: enteredFromGame,
                ),
          },
        ),
      ),
    );
  }
}
