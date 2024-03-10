import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/effects.dart';
import 'package:gitlab_hero/game/Player.dart';
import 'package:tiled/tiled.dart';
import 'package:flutter/animation.dart';
import 'package:flame_audio/flame_audio.dart';
import 'game.dart';


class Shopper extends SpriteAnimationComponent with  HasGameReference<MyGame> , CollisionCallbacks {
  bool hasCollided = false;
  Shopper({super.position, super.size, Vector2? targetPosition, }): super();


  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'shop.png',
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 0.1,
        textureSize: Vector2(50, 89),
      ),

    );

    ///position = game.size * 0.5;
    size = Vector2(30, 30);
    anchor = Anchor.bottomCenter;
    // final double radius = size.minDimension / 2;
    await add(CircleHitbox()..collisionType = CollisionType.passive);
    /*  final Vector2 op = Vector2(70, 110);
    await add(RectangleHitbox(size: op));*/
    await add(
      MoveEffect.by(
        Vector2(0, -7),
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
        FlameAudio.play(MyGame.plasticT);
      }
      removeAppearance();
      game.plData.plastic.value += 1;
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