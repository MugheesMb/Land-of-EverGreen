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
      backgroundColor: const Color.fromARGB(210, 229, 238, 238),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pause',
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
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 200,
                child: InkWell(
                  onTap: () {
                    // _mygame.resumeEngine();
                    gameRef.resumeEngine();
                    //  gameRef.overlays.remove(PauseMenu.id);
                    gameRef.popRoute();
                    //   gameRef.overlays.add(PauseButton.ID);
                  },
                  child: Image.asset("assets/images/resume-btn.png")
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
                    // gameRef.overlays.add(PauseButton.ID);
                    // gameRef.reset();
                    var gameplay = gameRef.findByKeyName<GamePlay>(GamePlay.id);
                    if(gameplay != null) {
                      gameRef.startLevel(gameplay.currentLevel);
                      gameRef.resumeEngine();
                    }
                  },
                  child: Image.asset("assets/images/restart-btn.png"),
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
                  child: Image.asset("assets/images/exit.png"),
                ),
              ),
            ],
          )),
    );
  }
}
