import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ever_green/game/game.dart';
import 'package:ever_green/main.dart';
import 'package:ever_green/routes/GamePlay.dart';

import '../game/game.dart';
import 'MainMenu.dart';


class PauseMenu extends StatelessWidget {
  static const  id = 'PauseMenu';

  final MyGame gameRef;
  const PauseMenu({Key? key, required this.gameRef , required this.vjoyValueListenable,
    this.onVjoyValueChanged,}) : super(key: key);

  final ValueListenable<bool> vjoyValueListenable;

  final ValueChanged<bool>? onVjoyValueChanged;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Settings',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 300,
                child: ValueListenableBuilder<bool>(
                  valueListenable: vjoyValueListenable,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return SwitchListTile(
                      value: value,
                      onChanged: onVjoyValueChanged,
                      title: child,
                    );
                  },
                  child: const Text('Virtual JoyStick'),
                ),
              ),
              SizedBox(
                height: 10.0,
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
                  child: Text('Resume')
                  ,
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
          )),
    );
  }
}
