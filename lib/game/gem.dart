import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/effects.dart';
import 'package:flutter/cupertino.dart';
import 'package:ever_green/game/Player.dart';
import 'package:ever_green/routes/GamePlay.dart';
import 'package:tiled/tiled.dart';
import 'package:flutter/animation.dart';

import 'game.dart';


import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';




class Gem extends SpriteComponent with CollisionCallbacks ,  HasGameReference<MyGame>  {

  bool hasCollided = false;


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
    if (other is Player && !hasCollided) {
      if(game.sfxValueNotifier.value){
        FlameAudio.play(MyGame.coinT);
      }

      removeAppearance();

      // Trigger camera shake

      game.plData.score.value += 1;
      hasCollided = true;
    }
  }


void removeAppearance(){
    addAll([
      OpacityEffect.fadeOut(
        LinearEffectController(0.4),
        onComplete: () => removeFromParent(),
      ),
      ScaleEffect.by(Vector2.all(1.2),LinearEffectController(0.4),)
    ]);
}
  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Player) {
      hasCollided = false; // Reset flag when player collision ends
    }
  }

}