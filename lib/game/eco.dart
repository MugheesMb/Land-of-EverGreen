import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/image_composition.dart';
import 'package:gitlab_hero/game/Player.dart';
import 'package:gitlab_hero/game/bottle.dart';
import 'package:flame_audio/flame_audio.dart';
import '../routes/GamePlay.dart';
import 'game.dart';


class Eco extends SpriteAnimationComponent with  HasGameReference<MyGame> , CollisionCallbacks {

  final VoidCallback? onPlayerCollision;

  Eco({super.position, super.size, Vector2? targetPosition, this.onPlayerCollision}): super();

/*  {

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
  }*/


  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'eco.png',
      SpriteAnimationData.sequenced(
        amount: 10,
        stepTime: 0.1,
        textureSize: Vector2(426, 240),
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
    if (other is Player) {// Call the method to remove all bottles
      if(game.sfxValueNotifier.value){
        FlameAudio.play(MyGame.ecoT);
      }

      onPlayerCollision!();
    removeFromParent();
      // Checks if player is hitting this enemy from the top.
      //  game.pauseGame();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void removeBottleFromGame() {
    // Iterate over the components to find Bottle instances and remove them
    final List<Bottle> bottles =  GamePlay(1).children.whereType<Bottle>().toList();
    for (final Bottle bottle in bottles) {
      bottle.removeAppearance(); // This will fade out and then remove the bottle
    }
  }
}