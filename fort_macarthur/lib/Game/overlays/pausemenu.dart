import 'package:flutter/material.dart';
import 'package:fort_macarthur/Game/gamescreens/mainmenu.dart';
import 'package:fort_macarthur/Game/overlays/pausebutton.dart';

import '../game/game_loop.dart';

class PauseMenu extends StatelessWidget {
  static const String ID = 'PauseMenu';
  final GameLoop gameRef;

  const PauseMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              'Game Paused',
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
                gameRef.overlays.remove(PauseMenu.ID);
                gameRef.overlays.add(PauseButton.ID);
              },
              child: Text('Resume'),
            ),
          ),

          // Options button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                gameRef.overlays.remove(PauseMenu.ID);
                gameRef.reset();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MainMenu(),
                  ),
                );
              },
              child: Text('Return to Menu'),
            ),
          ),
        ],
      ),
    );
  }
}
