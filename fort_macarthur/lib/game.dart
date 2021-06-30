import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:fort_macarthur/game_loop.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Game"),
        ),
        body: GameWidget(
          game: GameLoop(),
        ));
  }
}
