import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game_loop.dart';

void main() {
  runApp(MaterialApp(
    home: GameView(),
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
