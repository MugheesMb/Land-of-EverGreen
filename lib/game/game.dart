import 'package:ever_green/routes/recycle_screen.dart';
import 'package:ever_green/routes/trash_screen.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide OverlayRoute, Route;
import 'package:ever_green/game/story.dart';
import 'package:ever_green/routes/GamePlay.dart';
import 'package:ever_green/routes/MainMenu.dart';
import 'package:ever_green/routes/PauseMenu.dart';
import 'package:ever_green/routes/Retry.dart';
import 'package:ever_green/routes/levelSelection.dart';
import 'package:ever_green/routes/level_com.dart';
import 'package:ever_green/routes/settings.dart';

import '../hud/game_data.dart';

import 'dart:async';

import 'package:flame_audio/flame_audio.dart';

import 'bottle.dart';




class MyGame extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents {


  static const coinT = 'coin.wav';
  static const ecoT = 'eco.wav';
  static const enemyT = 'enemy.wav';
  static const jumpT = 'jump.wav';
  static const plasticT = 'plastic.wav';
  


  final  musicValueNotifier = ValueNotifier(true);
  final  sfxValueNotifier = ValueNotifier(true);
  final  vJoyValueNotifier = ValueNotifier(false);
  final plData = PlayData();
  late Sprite bu;


  @override
  Future<void> onLoad() async {

    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
    await add(router);
    await FlameAudio.audioCache.loadAll([coinT,ecoT,enemyT,plasticT,jumpT]);
    bu = await Sprite.load('enemy.png');
    
  }



  late final _routes  = <String, Route> {
    MainMenu.id: OverlayRoute((context,game) => MainMenu(
      gameRef: this,
      onPlayPressed: () => _routeById(LevelSelection.id),
      onSettingPressed: () => _routeById(Settings.id),
    )),
    LevelSelection.id: OverlayRoute((context,game) =>  LevelSelection(
      onLevelSelected: startLevel,
      onBackPressed: popRoute,

    )),
    Settings.id: OverlayRoute((context,game) => Settings(
      onBackPressed: popRoute, musicValueListenable: musicValueNotifier, sfxValueListenable: sfxValueNotifier,
      onMusicValueChanged: (value) => musicValueNotifier.value = value, onSfxValueChanged: (value) => sfxValueNotifier.value = value,
    )),
    LevComplete.id: OverlayRoute((context,game) =>  LevComplete(
      gameRef: this,
    )),
    PauseMenu.id: OverlayRoute((context,game) => PauseMenu(
      onVjoyValueChanged: (value) => vJoyValueNotifier.value = value,
      gameRef: this, vjoyValueListenable:vJoyValueNotifier,
    )),
    RetryMenu.id: OverlayRoute((context,game) => RetryMenu(
      gameRef: this,
    )),
    TrashScreen.id: OverlayRoute((context,game) => TrashScreen(
      gameRef:this,
    )),
  };

  late final router = RouterComponent(initialRoute: MainMenu.id, routes: _routes,);



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
        onPausePressed: pauseGame,
      key: ComponentKey.named(GamePlay.id),

    )),
    name: GamePlay.id
    );
  }
  void GameOver(){
    router.pushNamed(RetryMenu.id);
    pauseEngine();
  }
  void pauseGame(){
      router.pushNamed(PauseMenu.id);
      pauseEngine();
  }
  void LelCom(){
    router.pushNamed(LevComplete.id);
    pauseEngine();
  }

}