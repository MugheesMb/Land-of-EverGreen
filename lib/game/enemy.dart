import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/image_composition.dart';



class Enemy extends SpriteAnimationComponent with HasGameRef , CollisionCallbacks {
  Enemy({super.position, super.size });


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
    await add(CircleHitbox());
    /*  final Vector2 op = Vector2(70, 110);
    await add(RectangleHitbox(size: op));*/
  }
}