import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/cupertino.dart' hide Viewport;
import 'package:flame/camera.dart';
import 'package:gitlab_hero/game/game.dart';
import 'package:gitlab_hero/hud/game_data.dart';

import '../game/gem.dart';
import '../routes/PauseMenu.dart';
import '../routes/Retry.dart';







class Hud extends Component with  HasGameReference<MyGame> , ParentIsA<Viewport>   {
  Hud({super.children,});

  late final TextComponent healthTextComponent;
  late final TextComponent scoreTextComponent;


  @override
  Future<void> onLoad() async {

    final spriteImage = await Sprite.load('star.png');
    healthTextComponent = TextComponent(
      text: 'x5',
      anchor: Anchor.topRight,
      position: Vector2(parent.camera.viewport.virtualSize.x - 10  , 20 ),
    )
      ..debugMode = true;
    await add(healthTextComponent);

    scoreTextComponent = TextComponent(
      text: 'Score: 0',
      position: Vector2.all(10),
    );
    await add(scoreTextComponent);

    game.plData.health.addListener(onHealthChange);
    game.plData.score.addListener(onScoreChange);

    var gim =  Gem()
      ..sprite = await Sprite.load('star.png')
      ..anchor= Anchor.topRight
      ..size = Vector2.all(32)
    ..position = Vector2(
    healthTextComponent.position.x - healthTextComponent.size.x - 2, 20);
    await add(gim);


    final pauseButton = SpriteButtonComponent(
      onPressed: () {
       // AudioManager.pauseBgm();
        game.pauseGame();
      },
      button: Sprite(
          spriteImage.image,
        srcSize: Vector2.all(32),
        srcPosition: Vector2.zero(),
      ),

      size: Vector2.all(32),
      anchor: Anchor.topCenter,
      position: Vector2(parent.camera.viewport.virtualSize.x / 2, 5),
    );
    await add(pauseButton);
    return super.onLoad();
  }

  void onScoreChange() {
    scoreTextComponent.text = 'Score: ${game.plData.score.value}';
  }
  void onHealthChange() {
    healthTextComponent.text = 'x${game.plData.health.value}';
    if (game.plData.health.value == 0) {
     // AudioManager.stopBgm();
      game.GameOver();
    }
  }
}

