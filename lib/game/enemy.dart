import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/image_composition.dart';
import 'package:gitlab_hero/game/Player.dart';

import '../routes/GamePlay.dart';
import 'game.dart';


class Enemy extends SpriteAnimationComponent with  HasGameReference<MyGame> , CollisionCallbacks {

  static final Vector2 _up = Vector2(0, -1);
  Enemy({super.position, super.size, Vector2? targetPosition, }): super() {

    if (targetPosition != null && position != null) {
      // Need to sequence two move to effects so that we can
      // tap into the onFinishCallback and flip the component.
      final effect = SequenceEffect(
        [
          MoveToEffect(
            targetPosition,
            EffectController(speed: 100),
            onComplete: () => flipHorizontallyAroundCenter(),
          ),
          MoveToEffect(
            position + Vector2(32, 0), // Need to offset by 32 due to flip
            EffectController(speed: 100),
            onComplete: () => flipHorizontallyAroundCenter(),
          ),
        ],
        infinite: true,
      );

      add(effect);
    }
  }


  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'en.png',
      SpriteAnimationData.sequenced(
        amount: 5,
        stepTime: 0.1,
        textureSize: Vector2(310, 180),
      ),

    );

    ///position = game.size * 0.5;
    size = Vector2(50, 40);
    anchor = Anchor.bottomCenter;
    // final double radius = size.minDimension / 2;
    await add(CircleHitbox()..collisionType = CollisionType.passive);
    /*  final Vector2 op = Vector2(70, 110);
    await add(RectangleHitbox(size: op));*/
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      final playerDir = (other.absoluteCenter - absoluteCenter).normalized();

      // Checks if player is hitting this enemy from the top.
      if (playerDir.dot(_up) > 0.85) {
        // Fade out and remove this enemy and make the player auto-jump.
        add(
          OpacityEffect.fadeOut(
            LinearEffectController(0.2),
            onComplete: removeFromParent,
          ),
        );
        other.jump();
      } else {
        //AudioManager.playSfx('Hit_2.wav');
        other.hit();
        if (game.plData.health.value > 0) {
          game.plData.health.value -= 1;
        }
      }
      //  game.pauseGame();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}