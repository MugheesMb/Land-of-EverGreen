import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'dart:async';
import 'package:flame/camera.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flame/sprite.dart';
import 'package:ever_green/game/enemy.dart';
import 'package:ever_green/game/gound.dart';
import '../game/Player.dart';
import '../game/gem.dart';
import 'package:flame/experimental.dart';




class GamePlay extends Component with KeyboardHandler , HasGameRef{
  GamePlay(this.currentLevel,  {super.key, this.onPausePressed} );
  static const id  = 'GamePlay';

  final fixedResolution = Vector2(640, 360);
  final int currentLevel;
  final VoidCallback? onPausePressed;
  late Sprite _sprite;
  late Player _player;
  late final CameraComponent camera;

  @override
  Future<void> onLoad() async {
print('current: $currentLevel' );
      final map = await TiledComponent.load('mb2.tmx', Vector2.all(16));


      final world = World(children: [map]);
    await add(world);
    camera = CameraComponent.withFixedResolution(
      width: 640, height: 360, world: world
    );
    await add(camera);

    camera.moveTo(camera.viewport.virtualSize * 0.5);

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

final spawnPointLayer = map.tileMap.getLayer<ObjectGroup>('SpawnPoints');
final objects = spawnPointLayer?.objects;

if(objects != null) {
  for (final object in objects) {
    final position = Vector2(object.x * 0.5, object.y * 0.5);
    final size = Vector2(object.width, object.height);

    switch(object.class_){
      case 'Player':
        final halfSize = size * 0.5;
        final levelBounds = Rect.fromLTWH(
          halfSize.x,
          halfSize.y,
          map.size.x - halfSize.x,
          map.size.y - halfSize.y,
        );
        _player = Player(
          position: position ,
          children: [
            BoundedPositionBehavior(
              bounds: Rectangle.fromRect(levelBounds),
            ),
          ],

        )..debugMode = true;
        await world.add(_player);

      case 'coins':
        var gim =  Gem(tiledObject:  object)
          ..sprite = await Sprite.load('star.png')
          ..position = position
          ..size = size
          ..anchor = Anchor.centerRight;
        await world.add(gim);
      case 'enemy':
        final enemy = Enemy(
          position: position ,

        )..debugMode = true;
        await world.add(enemy);
    break;
  }
}

  _setupCamera(map);
}



return super.onLoad();

  }

 void _setupCamera(TiledComponent level) {
    camera.follow(_player, maxSpeed: 200);
   camera.setBounds(
      Rectangle.fromLTRB(

        fixedResolution.x / 2,
        fixedResolution.y / 2,
        level.width - fixedResolution.x / 2,
        level.height - fixedResolution.y / 2,
      ),
    );
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if(keysPressed.contains(LogicalKeyboardKey.keyP)) {
      onPausePressed?.call();
    }
    return super.onKeyEvent(event, keysPressed);

  }
}