import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// This class represents the actual game screen
// where all the action happens.
class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              SystemNavigator.pop();
              // TODO when i tried to pop out of the nav builder stack i get trapped on a blank page so this needs fixing here
            },
            child: Text('Leave'),
          ),
        ],
      ),
    );
  }
}
