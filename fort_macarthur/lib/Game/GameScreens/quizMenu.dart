import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'gameplay.dart';
import 'quizGameplay.dart';

// Represents the main menu screen of Spacescape, allowing
// players to start the game or modify in-game settings.
class QuizMenu extends StatelessWidget {
  const QuizMenu({Key? key}) : super(key: key);

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
                'Quiz Game',
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
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const QuizGameplay(),
                    ),
                  );
                },
                child: Text('Play'),
              ),
            ),

            // Options button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const GamePlay(),
                    ),
                  );
                },
                child: Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
