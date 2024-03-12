import 'package:flutter/material.dart';
import 'package:ever_green/game/game.dart';
import 'package:ever_green/routes/GamePlay.dart';

import 'MainMenu.dart';
import 'trash_screen.dart';


class RetryMenu extends StatelessWidget {
  static const  id = 'RetryMenu';

  final MyGame gameRef;
  const RetryMenu({Key? key, required this.gameRef}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(210, 229, 238, 238),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0),
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
                width: 200,
                child: InkWell(
                  onTap: () {
                    // gameRef.overlays.remove(PauseMenu.id);
                    // gameRef.overlays.add(PauseButton.ID);
                    // gameRef.reset();
                    var gameplay = gameRef.findByKeyName<GamePlay>(GamePlay.id);
                    if(gameplay != null) {
                      gameRef.startLevel(gameplay.currentLevel);
                      gameRef.resumeEngine();
                    }
                  },
                  child: Image.asset("assets/images/retry.png"),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 200,
                child: InkWell(
                  onTap: () {
                  //   gameRef.resumeEngine();
                  // gameRef.popRoute();
                  gameRef.router.pushReplacementNamed(TrashScreen.id);
                    // gameRef.overlays.remove(PauseMenu.id);
                    // gameRef.overlays.add(PauseButton.ID);
                    // gameRef.reset();
                    // var gameplay = gameRef.findByKeyName<GamePlay>(GamePlay.id);
                    // if(gameplay != null) {
                    //   gameRef.startLevel(gameplay.currentLevel);
                    //   gameRef.resumeEngine();
                    //}
                  },
                  child: Image.asset("assets/images/collection.png"),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 200,
                child: InkWell(
                  onTap: () {
                    // gameRef.overlays.remove(PauseMenu.id);
                    // gameRef.reset();
                    gameRef.resumeEngine();
                    gameRef.popRoute();
      
                    gameRef.router.pushReplacementNamed(MainMenu.id);
                  },
                  child:Image.asset("assets/images/exit.png"),
                ),
              ),
            ],
          )),
    );
  }
}
