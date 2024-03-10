import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/image_composition.dart';
import 'package:gitlab_hero/game/Player.dart';
import 'package:flame_audio/flame_audio.dart';
import '../routes/GamePlay.dart';
import 'game.dart';


class Enemy extends SpriteAnimationComponent with  HasGameReference<MyGame> , CollisionCallbacks {

  final VoidCallback? onPlayerCollision;
  bool hasCollided = false;



  static final Vector2 _up = Vector2(0, -1);
  Enemy({super.position, super.size, Vector2? targetPosition, this.onPlayerCollision}): super() {

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
   /*   'enee.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.1,
        textureSize: Vector2(400, 299),
      ),*/
      'men2.png',
      SpriteAnimationData.sequenced(
        amount: 9,
        stepTime: 0.1,
        textureSize: Vector2(426, 240),
      ),



    );

    ///position = game.size * 0.5;
    size = Vector2(80, 70);
    anchor = Anchor.bottomCenter;
    // final double radius = size.minDimension / 2;
    await add(CircleHitbox.relative(0.9, parentSize: size,)..collisionType = CollisionType.passive);
    /*  final Vector2 op = Vector2(70, 110);
    await add(RectangleHitbox(size: op));*/
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player && !hasCollided) {

      if(game.sfxValueNotifier.value){
        FlameAudio.play(MyGame.enemyT);
      }

      final playerDir = (other.absoluteCenter - absoluteCenter).normalized();
      onPlayerCollision!();
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
      hasCollided = true;
      //  game.pauseGame();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Player) {
      hasCollided = false; // Reset flag when player collision ends
    }
  }
}