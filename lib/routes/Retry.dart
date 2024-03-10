import 'package:flutter/material.dart';
import 'package:gitlab_hero/game/game.dart';
import 'package:gitlab_hero/routes/GamePlay.dart';

import 'MainMenu.dart';


class RetryMenu extends StatelessWidget {
  static const  id = 'RetryMenu';

  final MyGame gameRef;
  const RetryMenu({Key? key, required this.gameRef}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                'GameOver',
                style: TextStyle(
                  fontSize: 50.0,
                  //  fontFamily: 'BungeeInline',
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      blurRadius: 20.0,
                      color: Colors.white,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  // gameRef.overlays.remove(PauseMenu.id);
                  // gameRef.overlays.add(PauseButton.ID);
                  // gameRef.reset();
                  var gameplay = gameRef.findByKeyName<GamePlay>(GamePlay.id);
                  if(gameplay != null) {
                    gameRef.startLevel(gameplay.currentLevel);
                    gameRef.resumeEngine();
                  }
                },
                child: Text('Retry'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  // gameRef.overlays.remove(PauseMenu.id);
                  // gameRef.reset();
                  gameRef.resumeEngine();
                  gameRef.popRoute();

                  gameRef.router.pushReplacementNamed(MainMenu.id);
                },
                child: Text('Exit'),
              ),
            ),
          ],
        ));
  }
}
