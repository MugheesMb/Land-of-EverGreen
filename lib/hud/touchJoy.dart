import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:ever_green/game/game.dart';
import 'package:flame/flame.dart';
import '../game/Player.dart';

import 'package:flame/game.dart';



class TouchControls extends PositionComponent
    with HasGameReference<MyGame> {

  final Player player;
  TouchControls({
    required this.player,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
  })  : joystick = JoystickComponent(
    knob: SpriteComponent(
      sprite: Sprite(Flame.images.fromCache('SmallHandleFilledGrey.png')),
      size: Vector2.all(40),
    ),
    background: SpriteComponent(
      sprite: Sprite(Flame.images.fromCache('Joystick.png')),
      size: Vector2.all(70),
    ),
    position: Vector2(80,250),
    knobRadius: 40,
  ),attackButton = HudButtonComponent(
          button: SpriteComponent(sprite: Sprite(Flame.images.fromCache('SmallHandle.png')),
              size: Vector2.all(50)),
          buttonDown: SpriteComponent(
            sprite: Sprite(Flame.images.fromCache('SmallHandleFilledGrey.png')),
            size: Vector2.all(30),
          ),
          position: Vector2(500,230),
        );


  final JoystickComponent joystick;
  final HudButtonComponent attackButton;

  @override
  Future<void> onLoad() async {

    attackButton.onPressed = onAttackButtonPressed;
    game.vJoyValueNotifier.addListener(onVirutalJoystickSettingsChanged);



  }

  @override
  void update(double dt) {
  //  if (fluttor.state != FluttorState.talking) {
      if (joystick.isMounted) {
        if (joystick.isDragged) {
          player.actionInitiated = true;
          if (joystick.delta.x > 0.5) {
            player.hAxisInput = 1;
          } else if (joystick.delta.x < -0.5) {
            player.hAxisInput = -1;
          } else {
            player.hAxisInput = 0;
          }

          switch (joystick.direction) {
            case JoystickDirection.up:
            case JoystickDirection.upLeft:
            case JoystickDirection.upRight:
              //fluttor.state = FluttorState.jump;
              break;
            default:
              break;
          }

          if (joystick.delta.y < -0.5 ) {

          }
        } else {

          player.hAxisInput = 0;
        }
      }
   // }
  }

  @override
  void onRemove() {
    game.vJoyValueNotifier.removeListener(onVirutalJoystickSettingsChanged);
    super.onRemove();
  }



  void onVirutalJoystickSettingsChanged() {
    if (game.vJoyValueNotifier.value) {
      add(joystick);
      add(attackButton);

    } else {
      joystick.removeFromParent();
      attackButton.removeFromParent();

    }
  }
  void onAttackButtonPressed() {
    player.jump2();
  }

}
