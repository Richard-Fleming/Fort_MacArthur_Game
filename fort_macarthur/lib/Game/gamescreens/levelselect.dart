import 'package:flutter/material.dart';
import 'gameplay.dart';
import 'mainmenu.dart';

// Represents the main menu screen of Spacescape, allowing
// players to start the game or modify in-game settings.
class LevelSelect extends StatelessWidget {
  const LevelSelect({Key? key}) : super(key: key);
  final bool levelOneComplete = true;
  final bool levelTwoComplete = false;
  final bool levelThreeComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Game title.
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                'Pick a Level',
                style: TextStyle(
                  fontSize: 50.0,
                  color: Colors.black,
                ),
              ),
            ),

            // Level One
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  if (levelOneComplete) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const GamePlay(),
                      ),
                    );
                  }
                },
                child: levelOneComplete ? Text('Level One') : Text('LOCKED'),
              ),
            ),

            // Level Two
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  if (levelTwoComplete) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const GamePlay(),
                      ),
                    );
                  }
                },
                child: levelTwoComplete ? Text('Level Two') : Text('LOCKED'),
              ),
            ),

            // Level Three
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  if (levelThreeComplete) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const GamePlay(),
                      ),
                    );
                  }
                },
                child:
                    levelThreeComplete ? Text('Level Three') : Text('LOCKED'),
              ),
            ),

            // Exit button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const MainMenu(),
                    ),
                  );
                },
                child: Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
