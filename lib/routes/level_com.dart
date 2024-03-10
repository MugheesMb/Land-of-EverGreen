import 'package:flutter/material.dart';

import '../game/game.dart';
import 'GamePlay.dart';
import 'MainMenu.dart';

class LevComplete extends StatelessWidget {

  final MyGame gameRef;

  const LevComplete({

    required this.gameRef,
    super.key,
    this.onNextPressed,
  });

  static const id = 'LevComplete';



  final VoidCallback? onNextPressed;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(210, 229, 238, 238),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Level Completed',
              style: TextStyle(fontSize: 30),
            ),

            const SizedBox(height: 15),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Next'),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: () {
                  var gameplay = gameRef.findByKeyName<GamePlay>(GamePlay.id);
                  if(gameplay != null) {
                    gameRef.startLevel(gameplay.currentLevel);
                    gameRef.resumeEngine();
                  }
                },
                child: const Text('Retry'),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed:(){
                  gameRef.resumeEngine();
                  gameRef.popRoute();

                  gameRef.router.pushReplacementNamed(MainMenu.id);
                },
                child: const Text('Exit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}