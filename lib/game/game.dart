import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide OverlayRoute, Route;
import 'package:ever_green/routes/GamePlay.dart';
import 'package:ever_green/routes/MainMenu.dart';
import 'package:ever_green/routes/PauseMenu.dart';
import 'package:ever_green/routes/Retry.dart';
import 'package:ever_green/routes/levelSelection.dart';
import 'package:ever_green/routes/settings.dart';



class MyGame extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents {


  final  musicValueNotifier = ValueNotifier(true);
  final  sfxValueNotifier = ValueNotifier(true);


  late final _routes  = <String, Route> {
    MainMenu.id: OverlayRoute((context,game) => MainMenu(
      onPlayPressed: () => _routeById(LevelSelection.id),
      onSettingPressed: () => _routeById(Settings.id),
    )),
    LevelSelection.id: OverlayRoute((context,game) =>  LevelSelection(
      onLevelSelected: startLevel,
    )),
    Settings.id: OverlayRoute((context,game) => Settings(
      onBackPressed: popRoute, musicValueListenable: musicValueNotifier, sfxValueListenable: sfxValueNotifier,
      onMusicValueChanged: (value) => musicValueNotifier.value = value, onSfxValueChanged: (value) => sfxValueNotifier.value = value,
    )),
    //IntroRoute.id: OverlayRoute((context,game) => const IntroRoute()),
    PauseMenu.id: OverlayRoute((context,game) => PauseMenu(
      gameRef: this,
    )),
    RetryMenu.id: OverlayRoute((context,game) => RetryMenu(
      gameRef: this,
    ))
  };

  late final router = RouterComponent(initialRoute: MainMenu.id, routes: _routes,);

  @override
  Future<void> onLoad() async {
    await add(router);
  }

  void _routeById(String id) {
    router.pushNamed(id);
  }

  void popRoute() {
    router.pop();
  }

  void startLevel(int levelIndex) {
    router.pop();
    router.pushReplacement(Route(() => GamePlay(
      levelIndex,
        onPausePressed: _pauseGame,
      key: ComponentKey.named(GamePlay.id),

    )),
    name: GamePlay.id
    );
  }
  void _pauseGame(){
      router.pushNamed(PauseMenu.id);
      pauseEngine();
  }


}