import 'package:flutter/material.dart';
import 'package:ever_green/game/game.dart';
import 'package:ever_green/main.dart';
import 'package:ever_green/routes/GamePlay.dart';

import 'MainMenu.dart';


class PauseMenu extends StatelessWidget {
  static const  id = 'PauseMenu';

  final MyGame gameRef;
  const PauseMenu({Key? key, required this.gameRef}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                'Paused',
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
                 // _mygame.resumeEngine();
                 gameRef.resumeEngine();
                //  gameRef.overlays.remove(PauseMenu.id);
                 gameRef.popRoute();
               //   gameRef.overlays.add(PauseButton.ID);
                },
                child: Text('Resume'),
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
                 // gameRef.overlays.add(PauseButton.ID);
                 // gameRef.reset();
                  var gameplay = gameRef.findByKeyName<GamePlay>(GamePlay.id);
                  if(gameplay != null) {
                    gameRef.startLevel(gameplay.currentLevel);
                    gameRef.resumeEngine();
                  }
                },
                child: Text('Restart'),
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
