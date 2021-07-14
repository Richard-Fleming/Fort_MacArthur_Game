import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:fort_macarthur/Game/game/game_loop.dart';
import 'Game/GameScreens/MainMenu.dart';

void main() {
  runApp(MaterialApp(
    home: const MainMenu(),
  ));
}

class GameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game"),
      ),
      body: GameWidget(
        game: GameLoop(),
      ),
    );
  }
}
