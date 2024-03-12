import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/input.dart'; // Import for keyboard input
import 'dart:async' as async;
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'dart:async';
import 'package:flame/camera.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flame/sprite.dart';
import 'package:ever_green/game/bottle.dart';
import 'package:ever_green/game/eco.dart';
import 'package:ever_green/game/enemy.dart';
import 'package:ever_green/game/game.dart';
import 'package:ever_green/game/gamend.dart';
import 'package:ever_green/game/gound.dart';
import 'package:ever_green/game/plate.dart';
import 'package:ever_green/game/shopper.dart';
import '../game/Player.dart';
import '../game/bullet.dart';
import '../game/gem.dart';
import 'package:flame/experimental.dart';
import 'package:flame/effects.dart';
import '../game/grounf2.dart';
import '../hud/game_data.dart';
import '../hud/hud.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:flutter/widgets.dart';

import '../hud/touchJoy.dart';



class GamePlay extends Component with  KeyboardHandler , HasGameReference<MyGame>{

  static const coinT = 'coin.wav';
  static const ecoT = 'eco.wav';
  static const enemyT = 'enemy.wav';
  static const jumpT = 'jump.wav';
  static const plasticT = 'plastic.wav';
  // static const bgM = 'jump.wav';
  // static const storyM = 'jump.wav';

  GamePlay(this.currentLevel,  {super.key, this.onPausePressed} );
  static const id  = 'GamePlay';


  final fixedResolution = Vector2(620, 320);
  final int currentLevel;
  final VoidCallback? onPausePressed;
  late Sprite _sprite;
  late Player player;
  late final CameraComponent camera;
  late final _camShake = MoveEffect.by(
    Vector2(3, 0),
    InfiniteEffectController(ZigzagEffectController(period: 0.2)),
  );
  late final _camShake2 = MoveEffect.by(
    Vector2(15, 10),
    InfiniteEffectController(ZigzagEffectController(period: 0.2)),
  );



  late Hud hud;
 // final hud = Hud();
//static const _bgmVol = 0.1;
  AudioPlayer? _bgMusic;
  @override
  Future<void> onLoad() async {

    await FlameAudio.audioCache.loadAll([coinT,ecoT,enemyT,plasticT,jumpT]);
print('current: $currentLevel' );


    // if(game.musicValueNotifier.value) {
    //   _bgMusic = await  FlameAudio.loopLongAudio(MyGame.bgM, volume: _bgmVol );
    // }

      final map = await TiledComponent.load('mb3.tmx', Vector2.all(16));



      final world = World(children: [map]);
    await add(world);
    camera = CameraComponent.withFixedResolution(
      width: 620, height: 320, world: world
    );
    await add(camera);

    game.plData.health.value = 5;
    game.plData.score.value = 0;
    game.plData.plastic.value = 0;
//camera.follow(player);
    camera.moveTo(camera.viewport.virtualSize * 0.5);

    await camera.viewfinder.add(_camShake);


final ground = map.tileMap.getLayer<ObjectGroup>('Ground');

for (final gemm in ground!.objects) {

  switch(gemm.class_){
    case 'ground':

      final gro = Platform(
        position: Vector2(gemm.x * 0.5, gemm.y * 0.5),
        size: Vector2( gemm.width, gemm.height),
        anchor: Anchor.centerLeft
        ,);

      await world.add(gro);
      break;

  }

}

    final rounddrums = map.tileMap.getLayer<ObjectGroup>('Drums');

    for (final drumR in rounddrums!.objects) {
      switch (drumR.class_) {
        case 'drum':
          final vertices = <Vector2>[];

          for (final point in drumR.polygon) {
            vertices.add(Vector2(point.x * 0.5, point.y * 0.5));
          }
          final trail = TrailPoly(
            position: Vector2(drumR.x * 0.5, drumR.y * 0.5),
            vertices: vertices,
          );
          await map.add(trail);
          break;
      }
    }

    final trashplas = map.tileMap.getLayer<ObjectGroup>('trash');

    for (final plast in trashplas!.objects) {
      final position = Vector2(plast.x * 0.5, plast.y * 0.5);
      final size = Vector2(plast.width, plast.height);
      switch (plast.class_) {
        case 'plate':
          final platee = Plate(
            position: position ,
            targetPosition: Vector2(plast!.x * 0.5, plast!.y * 0.5),
          );
          await world.add(platee);
          break;
        case 'shopper':
          final shopp = Shopper(
            position: position ,
            targetPosition: Vector2(plast!.x * 0.5, plast!.y * 0.5),
          );
          await world.add(shopp);
          break;
        case 'bottle':
          final shopp = Bottle(
            position: position ,
            targetPosition: Vector2(plast!.x * 0.5, plast!.y * 0.5),
          );
          await world.add(shopp);
          break;
      }
    }



final spawnPointLayer = map.tileMap.getLayer<ObjectGroup>('SpawnPoints');
final objects = spawnPointLayer?.objects;

if(objects != null) {
  for (final objc in objects) {
    final position = Vector2(objc.x * 0.5, objc.y * 0.5);
    final size = Vector2(objc.width, objc.height);

    switch(objc.class_){

      
      case 'Player':
        final halfSize = size * 0.5;
        final levelBounds = Rect.fromLTWH(
          halfSize.x,
          halfSize.y,
          map.size.x - halfSize.x,
          map.size.y - halfSize.y,
        );
        player = Player(
          position: position ,
          children: [
            BoundedPositionBehavior(
              bounds: Rectangle.fromRect(levelBounds),
            ),
          ],

        );
          //..debugMode = true;

        await world.add(player);
        break;
      case 'coins':
        var gim =  Gem()
          ..sprite = await Sprite(Flame.images.fromCache('star.png'))
          ..position = position
          ..size = size
          ..anchor = Anchor.centerRight;
        await world.add(gim);
        break;
      case 'end':
        var gim2 =  GemEnd()
          ..sprite = await Sprite(Flame.images.fromCache('fs.png'))
          ..position = position
          ..size = size
          ..anchor = Anchor.centerRight;
        await world.add(gim2);
        break;
      case 'diamond':
        var dia =  Eco(
          onPlayerCollision: () {
            // Implement or call the camera shake function here
            // For example: gameRef.shakeCamera();
            triggerCameraShake2();
          },
          position: position ,
         size: size,
         // targetPosition: Vector2(target!.x * 0.5, target!.y * 0.5),
        );
        await world.add(dia);
        break;
      case 'enemy':
        final targetObjectId =
        int.parse(objc.properties.first.value.toString());
        final target = spawnPointLayer?.objects
            .firstWhere((object) => object.id == targetObjectId);
        final enemy = Enemy(
          onPlayerCollision: () {
            // Implement or call the camera shake function here
            // For example: gameRef.shakeCamera();
            triggerCameraShake();
          },
          position: position ,
          targetPosition: Vector2(target!.x * 0.5, target!.y * 0.5),

        );
        //..debugMode = true;
        await world.add(enemy);
    break;
  }
}

  _setupCamera(map);
}

    hud = Hud(player: player);
    await camera.viewport.addAll([hud, ]);

  /*  Bullet bullet = Bullet(
      sprite:  game.bu,
      size: Vector2(54, 54),
      position: this._player.position.clone() * 0.3,
    );
    bullet.anchor = Anchor.center;
    await map.add(bullet);*/



    return super.onLoad();

  }



  
  void triggerCameraShake() {
    // Ensure the effect is reset and ready to run again
    _camShake.reset();

    camera.viewfinder.add(_camShake);
    async.Timer(const Duration(seconds: 1), () {
      // Stop the shake effect
      _camShake.removeFromParent();
    });
    //_camShake.onStart();
  }
  void triggerCameraShake2() {
    // Ensure the effect is reset and ready to run again
    _camShake2.reset();

    camera.viewfinder.add(_camShake2);
    async.Timer(const Duration(seconds: 3), () {
      // Stop the shake effect
      _camShake2.removeFromParent();
    });
    //_camShake.onStart();
  }

void _setupCamera(TiledComponent level) {

    camera.follow(player, maxSpeed: 250);
   camera.setBounds(
      Rectangle.fromLTRB(

        fixedResolution.x / 2,
        fixedResolution.y / 2,
        level.width - fixedResolution.x / 1,
        level.height - fixedResolution.y / 1,
      ),
    );
  }





  @override
  bool onKeyEvent(event, Set<LogicalKeyboardKey> keysPressed) {
    if(keysPressed.contains(LogicalKeyboardKey.keyP)) {
      onPausePressed?.call();
    }

  //  return KeyEventResult.ignored;
    return super.onKeyEvent(event, keysPressed);

  }

}