import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/effects.dart';
import 'package:flutter/cupertino.dart';
import 'package:gitlab_hero/game/Player.dart';
import 'package:gitlab_hero/routes/GamePlay.dart';
import 'package:tiled/tiled.dart';
import 'package:flutter/animation.dart';

import 'game.dart';


import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';




class GemEnd extends SpriteComponent with CollisionCallbacks ,  HasGameReference<MyGame>  {




  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(CircleHitbox()..collisionType = CollisionType.passive);
    // print(tiledObject.id);
   // debugMode = true;
    await add(
      MoveEffect.by(
        Vector2(0, -15),
        EffectController(
          alternate: true,
          infinite: true,
          duration: 1,
          curve: Curves.ease,
        ),
      ),
    );
  }

  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Player) {

      game.LelCom();

    }
  }


}