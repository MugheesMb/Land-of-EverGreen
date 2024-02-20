

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/effects.dart';
import 'package:tiled/tiled.dart';
import 'package:flutter/animation.dart';


class Gem extends SpriteComponent {
  final TiledObject tiledObject;

  Gem({required this.tiledObject});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(CircleHitbox()..collisionType = CollisionType.passive);
    print(tiledObject.id);
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