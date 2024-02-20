import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/services.dart';
import 'package:ever_green/game/gem.dart';
import 'package:ever_green/game/gound.dart';
import 'dart:math' as math;


class Player extends SpriteAnimationComponent with HasGameRef , CollisionCallbacks, KeyboardHandler {
  Player({super.position,super.size ,  Iterable<Component>? children,}): super(
    children: children,
  );

  int _hAxisInput = 0;
  bool _isOnGround = false;
  final double _movespeed = 200;
  final double _gravity = 10;
  final double _jumpSpeed = 320;
  final Vector2 _up = Vector2(0, -1);
  bool _jumpInput = false;
  final Vector2 _velocity = Vector2.zero();
  int _nHitboxesInContact = 0;


  @override
  Future<void> onLoad() async {




    animation = await game.loadSpriteAnimation(
      'mb1.png',
      SpriteAnimationData.sequenced(
        amount: 5,
        stepTime: 0.1,
        textureSize: Vector2(750, 900),

      ),

    );
    ///position = game.size * 0.5;
    size = Vector2(100, 120);
    anchor = Anchor.bottomCenter;
   // final double radius = size.minDimension / 2;
    await add(CircleHitbox());
  /*  final Vector2 op = Vector2(70, 110);
    await add(RectangleHitbox(size: op));*/
  }

  @override
  void update(double dt) {
    // Apply horizontal movement based on input.
    if (_nHitboxesInContact == 0 && _isOnGround && _velocity.y == 0) {
      _isOnGround = false;
    }
    _velocity.x = _hAxisInput * _movespeed;

    // Apply gravity continuously. If the player is on the ground, we shouldn't add gravity.
    if (!_isOnGround) {
      // Apply gravity
      _velocity.y += _gravity;
    } else if (!_jumpInput) {
      // Ensure the player doesn't keep sinking or floating if they are on the ground and not jumping
      _velocity.y = 0;
    }

    // Handle jumping logic - only jump if on the ground.
    if (_jumpInput && _isOnGround) {
      _velocity.y = -_jumpSpeed; // Apply jump velocity upwards.
      _isOnGround = false; // Player leaves the ground.
      _jumpInput = false; // Reset jump input to prevent repeated jumps.
    }

    // Clamp vertical velocity to avoid exceeding jump speed or falling too fast.
    _velocity.y = _velocity.y.clamp(-_jumpSpeed, _gravity * 30);

    // Update the player's position based on the velocity.
    position += _velocity * dt;


    // Handle player orientation based on movement direction.
    if (_hAxisInput < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (_hAxisInput > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    super.update(dt);
  }


  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _hAxisInput = 0;

    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.keyA) ? -1 : 0;
    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.keyD) ? 1 : 0;
    _jumpInput = keysPressed.contains(LogicalKeyboardKey.space);

    return true;
  }
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Gem) {
      other.removeAppearance();
    }

    if (other is Platform) {
      if (intersectionPoints.length == 2) {
        // Calculate the collision normal and separation distance.
        final mid = (intersectionPoints.elementAt(0) +
            intersectionPoints.elementAt(1)) /
            2;

        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        collisionNormal.normalize();

        // If collision normal is almost upwards,
        // player must be on ground.
        if (_up.dot(collisionNormal) > 0.9) {
          _isOnGround = true;
        }

        // Resolve collision by moving player along
        // collision normal by separation distance.
        position += collisionNormal.scaled(separationDistance);
      }
    }
  }
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    ++_nHitboxesInContact;
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    --_nHitboxesInContact;
  }
  }