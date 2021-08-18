import 'package:flutter/material.dart';
import 'package:fort_macarthur/Game/GameScreens/mainmenu.dart';
import 'package:fort_macarthur/Game/game/game_loop.dart';
import 'package:fort_macarthur/Game/overlays/quizMenu.dart';

class ResultPage extends StatefulWidget {
  int marks;
  final GameLoop gameRef;
  ResultPage({Key? key, required this.marks, required this.gameRef})
      : super(key: key);
  @override
  _ResultPageState createState() => _ResultPageState(marks, gameRef);
}

class _ResultPageState extends State<ResultPage> {
  List<String> images = [
    "assets/images/quiz/perfect.png",
    "assets/images/quiz/good.png",
    "assets/images/quiz/fail.png",
  ];

  late String message;
  late String image;

  @override
  void initState() {
    if (marks < 20) {
      image = images[2];
      message = "You Should Try Hard..\n" + "You Scored $marks";
    } else if (marks < 45) {
      image = images[1];
      message = "You Can Do Better..\n" + "You Scored $marks";
    } else {
      image = images[0];
      message = "You Did Very Well..\n" + "You Scored $marks";
    }
    super.initState();
  }

  int marks;

  final GameLoop gameRef;
  _ResultPageState(this.marks, this.gameRef);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Result",
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Material(
              elevation: 10.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        width: 300.0,
                        height: 300.0,
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(
                              image,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 15.0,
                        ),
                        child: Center(
                          child: Text(
                            message,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Quando",
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    gameRef.reset();
                    gameRef.overlays.remove(QuizMenu.ID);
                    // Push and replace current screen (i.e MainMenu) with
                    // SelectSpaceship(), so that player can select a spaceship.
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MainMenu(),
                      ),
                    );
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
