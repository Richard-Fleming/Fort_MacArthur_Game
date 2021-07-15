import 'package:flutter/material.dart';
import 'package:fort_macarthur/Game/gamescreens/mainmenu.dart';

import '../game/game_loop.dart';

class GameOverMenu extends StatelessWidget {
  static const String ID = 'GameOver';
  final GameLoop gameRef;

  const GameOverMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              'Game Over',
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
                gameRef.resumeEngine();
              },
              child: Text('Back to Menu'),
            ),
          ),

          // Options button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                gameRef.reset();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MainMenu(),
                  ),
                );
              },
              child: Text('Exit'),
            ),
          ),
        ],
      ),
    );
  }
}
