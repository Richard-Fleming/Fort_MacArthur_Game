import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fort_macarthur/game_loop.dart';

class QuizScreen extends StatelessWidget {
  final GameLoop gameRef;
  QuizScreen({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              'Quiz',
              style: TextStyle(fontSize: 50.0, color: Colors.red, shadows: [
                Shadow(
                    blurRadius: 20.0, color: Colors.blue, offset: Offset(0, 0))
              ]),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Start'),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Go to next mission'),
            ),
          )
        ],
      ),
    );
  }
}
