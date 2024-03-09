import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/effects.dart';
import 'package:gitlab_hero/game/Player.dart';
import 'package:tiled/tiled.dart';
import 'package:flutter/animation.dart';

import 'game.dart';


class Gem extends SpriteComponent with CollisionCallbacks ,  HasGameReference<MyGame>  {




  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(CircleHitbox()..collisionType = CollisionType.passive);
   // print(tiledObject.id);
    debugMode = true;
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
      removeAppearance();
      game.plData.score.value += 1;
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

}