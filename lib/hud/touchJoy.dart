/*
import 'package:ever_green/game/Player.dart';
import 'package:ever_green/game/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/widgets.dart';

import '../game/Player.dart';


class TouchControls extends PositionComponent with HasGameRef<MyGame> {
  final Player Player;
  TouchControls({
    required Sprite joystickKnob,
    required Sprite joystickBackground,
    */
/*required Sprite attackButton,
    required Sprite attackButtonDown,
    required Sprite pauseButton*//*

    required this.fluttor,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
  })  : joystick = JoystickComponent(
    knob: SpriteComponent(
      sprite: joystickKnob,
      size: Vector2.all(100),
    ),
    background: SpriteComponent(
        sprite: joystickBackground, size: Vector2.all(200)),
    margin: const EdgeInsets.only(left: 100, bottom: 100),
    knobRadius: 60,
  ),
       */
/* attackButton = HudButtonComponent(
          button: SpriteComponent(sprite: attackButton, size: Vector2.all(100)),
          buttonDown: SpriteComponent(
            sprite: attackButtonDown,
            size: Vector2.all(80),
          ),
          margin: const EdgeInsets.only(right: 150, bottom: 150),
        ),
        pauseButton = HudButtonComponent(
          button: SpriteComponent(sprite: pauseButton, size: Vector2.all(50)),
          margin: const EdgeInsets.only(top: 30, right: 30),
        ) {
    positionType = PositionType.viewport;*//*

  }

  late final JoystickComponent joystick;
  */
/*final HudButtonComponent attackButton;
  final HudButtonComponent pauseButton;*//*


  @override
  Future<void>? onLoad() async {
    await add(pauseButton);
  */
/*  pauseButton.onPressed = onPauseButtonPressed;
    attackButton.onPressed = onAttackButtonPressed;*//*


    gameRef.settings.virtualJoystick
        .addListener(onVirutalJoystickSettingsChanged);

    // add(joystick);
    // add(attackButton);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (fluttor.state != FluttorState.talking) {
      if (joystick.isMounted) {
        if (joystick.isDragged) {
          if (joystick.delta.x > 0.5) {
            fluttor.xAxisInput = 1;
          } else if (joystick.delta.x < -0.5) {
            fluttor.xAxisInput = -1;
          } else {
            fluttor.xAxisInput = 0;
          }
        } else {
          fluttor.xAxisInput = 0;
        }
      }
    }
    super.update(dt);
  }

  @override
  void onRemove() {
    gameRef.settings.virtualJoystick
        .removeListener(onVirutalJoystickSettingsChanged);
    super.onRemove();
  }

 */
/* void onPauseButtonPressed() {
    if (gameRef.paused) {
      AudioManager.resumeBgm();
      gameRef.resumeEngine();
      gameRef.overlays.remove(PauseMenu.id);
    } else {
      AudioManager.pauseBgm();
      gameRef.pauseEngine();
      gameRef.overlays.add(PauseMenu.id);
    }
  }*//*


  void onVirutalJoystickSettingsChanged() {
    if (gameRef.settings.virtualJoystick.value) {
      add(joystick);
      add(attackButton);
    } else {
      joystick.removeFromParent();
      attackButton.removeFromParent();
    }
  }

*/
/*  void onAttackButtonPressed() {
    if (fluttor.state != FluttorState.talking) {
      fluttor.state = FluttorState.attack;
    }
  }*//*

}
*/
