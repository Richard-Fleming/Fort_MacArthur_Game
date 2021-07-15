import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fort_macarthur/Game/gamescreens/mainmenu.dart';
import '../game/game_loop.dart';

class GameOverMenu extends StatelessWidget {
  static const String ID = 'GameOver';
  final GameLoop gameRef;

  const GameOverMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 100.0,
            vertical: 50.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Game Over',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        child: Text(
                          'Main Menu',
                          style: TextStyle(fontSize: 10.0),
                        ),
                        onPressed: () {
                          // Push and replace current screen (i.e MainMenu) with
                          // SelectSpaceship(), so that player can select a spaceship.
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const MainMenu(),
                            ),
                          );
                        },
                      ),
                      ElevatedButton(
                        child: Text(
                          'Close Game',
                          style: TextStyle(fontSize: 10.0),
                        ),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
