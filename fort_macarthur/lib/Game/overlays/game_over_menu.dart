import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fort_macarthur/Game/GameScreens/levelselect.dart';
import 'package:fort_macarthur/Game/gamescreens/mainmenu.dart';
import 'package:fort_macarthur/Game/models/sound_manager.dart';
import '../game/game_loop.dart';

class GameOverMenu extends StatelessWidget {
  static const String ID = 'GameOver';
  final GameLoop gameRef;
  final bool enteredFromGame;

  const GameOverMenu(
      {Key? key, required this.gameRef, required this.enteredFromGame})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 100.0,
            vertical: 50.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Game Over',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      enteredFromGame
                          ? ElevatedButton(
                              child: Text(
                                'Main Menu',
                                style: TextStyle(fontSize: 10.0),
                              ),
                              onPressed: () {
                                SoundManager.play(SoundFx.uiConfirm);

                                gameRef.reset();
                                gameRef.overlays.remove(GameOverMenu.ID);
                                // Push and replace current screen (i.e MainMenu) with
                                // SelectSpaceship(), so that player can select a spaceship.
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const MainMenu(),
                                  ),
                                );
                              },
                            )
                          : ElevatedButton(
                              child: Text(
                                'Level Select',
                                style: TextStyle(fontSize: 10.0),
                              ),
                              onPressed: () {
                                SoundManager.play(SoundFx.uiConfirm);

                                gameRef.reset();
                                gameRef.overlays.remove(GameOverMenu.ID);

                                // Push and replace current screen (i.e MainMenu) with
                                // SelectSpaceship(), so that player can select a spaceship.
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LevelSelect(),
                                  ),
                                );
                              },
                            ),
                      ElevatedButton(
                        child: Text(
                          'Close Game',
                          style: TextStyle(fontSize: 10.0),
                        ),
                        onPressed: () {
                          SoundManager.play(SoundFx.uiCancel);
                          SoundManager.disposeAll();

                          gameRef.overlays.remove(GameOverMenu.ID);
                          SystemNavigator.pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
