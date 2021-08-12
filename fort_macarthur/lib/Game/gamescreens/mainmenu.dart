import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fort_macarthur/Game/models/sound_manager.dart';

import 'gameplay.dart';
import 'options.dart';
import 'levelselect.dart';

// Represents the main menu screen of Spacescape, allowing
// players to start the game or modify in-game settings.
class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SoundManager.init();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Game title.
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                'Fort Missile',
                style: TextStyle(
                  fontSize: 50.0,
                  color: Colors.black,
                ),
              ),
            ),

            // Play button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  // Push and replace current screen (i.e MainMenu) with
                  // SelectSpaceship(), so that player can select a spaceship.
                  SoundManager.play(SoundFx.uiConfirm);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          const GamePlay(enteredFromGame: true),
                    ),
                  );
                },
                child: Text('Play'),
              ),
            ),

            // Level Select button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  // Push and replace current screen (i.e MainMenu) with
                  // SelectSpaceship(), so that player can select a spaceship.
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LevelSelect(),
                    ),
                  );
                },
                child: Text('Level Select'),
              ),
            ),

            // Options button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  SoundManager.play(SoundFx.uiConfirm);

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Options(),
                    ),
                  );
                },
                child: Text('Options'),
              ),
            ),

            // Exit button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  SoundManager.play(SoundFx.uiCancel);

                  SoundManager.disposeAll();
                  SystemNavigator.pop();
                },
                child: Text('Exit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
