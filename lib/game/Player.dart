import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/services.dart';
import 'package:ever_green/game/game.dart';
import 'package:ever_green/game/gem.dart';
import 'package:ever_green/game/gound.dart';
import 'dart:math' as Math;
import 'package:flame_audio/flame_audio.dart';
import 'package:ever_green/game/grounf2.dart';
import 'package:flame/flame.dart';
import 'bullet.dart';



class Player extends SpriteAnimationComponent with HasGameRef<MyGame> , CollisionCallbacks, KeyboardHandler {
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
  SpriteAnimation? _walkingAnimation;
  SpriteAnimation? _idleAnimation;
  SpriteAnimation? _jumpAnimation;
  double startY = 0; // Y-coordinate when the jump starts
  bool hasJumped = false;
  @override
  Future<void> onLoad() async {
    _walkingAnimation = await SpriteAnimation.fromFrameData(
      Flame.images.fromCache('her2.png'),
      SpriteAnimationData.sequenced(
        amount: 7,
        textureSize: Vector2(750, 422),
        stepTime: 0.1,
      ),
    );


    _idleAnimation =  await SpriteAnimation.fromFrameData(
      Flame.images.fromCache('her3.png'),
      SpriteAnimationData.sequenced(
        amount: 1,
        textureSize: Vector2(750, 422),
        stepTime: 0.1,
      ),
    );


    _jumpAnimation = await SpriteAnimation.fromFrameData(
      Flame.images.fromCache('new.png'),
      SpriteAnimationData.sequenced(
        amount: 1,
        textureSize: Vector2(750, 422),
        stepTime: 0.1,
      ),
    );


    ///position = game.size * 0.5;
    animation = _idleAnimation;
    size = Vector2(95, 95);
    anchor = Anchor.bottomCenter;
   // final double radius = size.minDimension / 2;
    await add(CircleHitbox.relative(1, parentSize: Vector2(95, 95)));


  }



  @override
  void update(double dt) {
    bool isInAir = !_isOnGround;
    print("Velocity Y: $_velocity.y, IsOnGround: $_isOnGround, JumpInput: $_jumpInput , isInnAir: $isInAir , hasJumped: $hasJumped, startY: $startY");
    // Apply horizontal movement based on input.
    if (_nHitboxesInContact == 0 && _isOnGround &&  _velocity.y == 0) {
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

      if(game.sfxValueNotifier.value){
        FlameAudio.play(MyGame.jumpT);
      }


      _velocity.y = -_jumpSpeed; // Apply jump velocity upwards.
      _isOnGround = false; // Player leaves the ground.
      _jumpInput = false; // Reset jump input to prevent repeated jumps.
    }


    // Clamp vertical velocity to avoid exceeding jump speed or falling too fast.
    _velocity.y = _velocity.y.clamp(-_jumpSpeed, _gravity * 30);

    // Update the player's position based on the velocity.
    position += _velocity * dt;




    // Check for the start of a jump
    if (!_isOnGround && !hasJumped) {
      startY = position.y; // Record the starting Y-coordinate of the jump
      hasJumped = true; // Mark that the jump has started
    }
    // Update the animation based on the player's state and elevation
    if (isInAir) {
      // Check if the player has moved at least 2 cm (20 units) above the start Y-coordinate
      if (hasJumped && (startY - position.y) >= 20) {
        // If yes, trigger the jump animation
        if (animation != _idleAnimation) {
          animation = _idleAnimation;
        }
      }
     /* else if (animation != _idleAnimation) {
        // Use the idle animation for smaller elevations
        animation = _idleAnimation;
      }*/
    } else {
      // Determine if the player is idle or walking when on the ground
      bool isIdle = _hAxisInput == 0;
      if (isIdle) {
        // Player is idle on the ground
        if (animation != _idleAnimation) {
          animation = _idleAnimation;
        }
      } else {
        // Player is walking on the ground
        if (animation != _walkingAnimation) {
          animation = _walkingAnimation;
        }
      }
    }

    // Reset the jump flag and startY when the player lands back on the ground
    if (_isOnGround && hasJumped) {
      hasJumped = false;
      startY = 0;
    }




    // Handle player orientation based on movement direction.
    if (_hAxisInput < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (_hAxisInput > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    super.update(dt);
  }


  @override
  bool onKeyEvent(event, Set<LogicalKeyboardKey> keysPressed) {
    _hAxisInput = 0;

    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.keyA) ? -1 : 0;
    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.keyD) ? 1 : 0;
    _jumpInput = keysPressed.contains(LogicalKeyboardKey.space);
    // Add shooting handling
   /* if (keysPressed.contains(LogicalKeyboardKey.keyF)) {
      shoot();
    }*/

    return true;
  }

 /* void shoot() {
    Bullet bullet = Bullet(
      sprite: game.bu,
      size: Vector2(64, 64),
      position: position.clone() * 0.3,
    );

    // Anchor it to center and add to game world.
    bullet.anchor = Anchor.center;
    gameRef.add(bullet);
  }*/


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {


    if (other is Platform || other is TrailPoly) {
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
  void hit() {
    add(
      OpacityEffect.fadeOut(
        EffectController(
          alternate: true,
          duration: 0.1,
          repeatCount: 5,
        ),
      ),
    );
  }

  void jump() {
    _jumpInput = true;
    _isOnGround = true;
  }
}