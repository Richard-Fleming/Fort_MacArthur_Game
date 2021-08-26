import 'package:flutter/material.dart';
import 'package:fort_macarthur/Game/gamescreens/mainmenu.dart';

//import '../GameScreens/gameplay.dart';
import '../game/game_loop.dart';
import 'quizGameplay.dart';

// Represents the main menu screen of Spacescape, allowing
// players to start the game or modify in-game settings.
class QuizMenu extends StatelessWidget {
  static const String ID = 'Quiz';
  final GameLoop gameRef;
  final String quizData = "Battery Osgood - Farley";

  const QuizMenu({Key? key, required this.gameRef}) : super(key: key);

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
                      builder: (context) => GetJson(quizData, gameRef),
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
                  gameRef.reset();
                  gameRef.overlays.remove(QuizMenu.ID);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const MainMenu()),
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
