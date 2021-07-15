import 'package:flutter/material.dart';
import 'package:fort_macarthur/Game/overlays/pausemenu.dart';

import '../game/game_loop.dart';

class PauseButton extends StatelessWidget {
  static const String ID = 'PauseButton';
  final GameLoop gameRef;

  const PauseButton({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Column(
        children: [
          // Game title.
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: TextButton(
              child: Icon(
                Icons.pause_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                gameRef.pauseEngine();
                gameRef.overlays.add(PauseMenu.ID);
                gameRef.overlays.remove(PauseButton.ID);
              },
            ),
          ),
        ],
      ),
    );
  }
}
