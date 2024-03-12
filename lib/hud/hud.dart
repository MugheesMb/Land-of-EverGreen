import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/cupertino.dart' hide Viewport;
import 'package:flame/camera.dart';
import 'package:ever_green/game/game.dart';
import 'package:ever_green/hud/game_data.dart';
import 'package:flame/text.dart';
import 'package:ever_green/hud/touchJoy.dart';
import 'package:ever_green/routes/GamePlay.dart';
import '../game/Player.dart';
import '../game/gem.dart';
import '../routes/PauseMenu.dart';
import '../routes/Retry.dart';







class Hud extends Component with  HasGameReference<MyGame> , ParentIsA<Viewport>   {
  final Player player;



  Hud({super.children, required this.player,});

  late final TextComponent healthTextComponent;
  late final TextComponent scoreTextComponent;
  late final TextComponent plasticTextComponent;


  @override
  Future<void> onLoad() async {




    final _spriteImage = await Sprite(Flame.images.fromCache('play.png'));
    final _spriteImage2 = await Sprite(Flame.images.fromCache('star.png'));
    final _spriteImage3 = await Sprite(Flame.images.fromCache('bin.png'));
    final _spriteImage4 = await Sprite(Flame.images.fromCache('head.png'));
    healthTextComponent = TextComponent(
      text: 'x5',
      textRenderer: TextPaint(style: TextStyle(
        fontSize: 20.0, // Specify a smaller font size here
        color: Color.fromARGB(255, 255, 255, 255),
      )),
      anchor: Anchor.topRight,
      position: Vector2(parent.camera.viewport.virtualSize.x - 8  , 13 ),
    );
      //..debugMode = true;
    await add(healthTextComponent);

    final ScoPic = SpriteComponent(

       sprite: Sprite(
        _spriteImage2.image,
        srcSize: Vector2.all(32),
        srcPosition: Vector2.zero(),
      ),

      size: Vector2.all(30),
      anchor: Anchor.topCenter,
      position: Vector2(16,4),
    );
    await add(ScoPic);
    scoreTextComponent = TextComponent(
      text: 'x0',
      textRenderer: TextPaint(style: TextStyle(
        fontSize: 20.0, // Specify a smaller font size here
        color: Color.fromARGB(255, 255, 255, 255),
      )),
      position: Vector2(28,6),
    );
    await add(scoreTextComponent);

     final touchControls = TouchControls(
    //  position:Vector2(50,150),
      priority: 1,
       player: player,
      
    );
    await add(touchControls);

    final ScoPic2 = SpriteComponent(

      sprite: Sprite(
        _spriteImage3.image,
        srcSize: Vector2.all(32),
        srcPosition: Vector2.zero(),
      ),

      size: Vector2.all(25),
      anchor: Anchor.topCenter,
      position: Vector2(70,6),
    );
    await add(ScoPic2);

    plasticTextComponent = TextComponent(
      text: 'x0',
      textRenderer: TextPaint(style: TextStyle(
          fontSize: 20.0, // Specify a smaller font size here
          color: Color.fromARGB(255, 255, 255, 255),
      )),
      position: Vector2(80,6),
    );
    await add(plasticTextComponent);

    game.plData.health.addListener(onHealthChange);
    game.plData.score.addListener(onScoreChange);
    game.plData.plastic.addListener(onPlasticChange);



    final ScoPic3 = SpriteComponent(

        sprite: Sprite(
          _spriteImage4.image,
         // srcSize: Vector2.all(32),
          srcPosition: Vector2.zero(),
        ),

      size: Vector2(40,29),
      anchor: Anchor.topCenter,
      position: Vector2(
          healthTextComponent.position.x - healthTextComponent.size.x - 14, 9),
    );

    await add(ScoPic3);


    final pauseButton = SpriteButtonComponent(
      onPressed: () {
       // AudioManager.pauseBgm();
        game.pauseGame();
      },
      button: Sprite(
          _spriteImage.image,
        srcSize: Vector2.all(32),
        srcPosition: Vector2.zero(),
      ),

      size: Vector2.all(27),
      anchor: Anchor.topCenter,
      position: Vector2(parent.camera.viewport.virtualSize.x / 2, 5),
    );
    await add(pauseButton);
    return super.onLoad();
  }

  void onScoreChange() {
    scoreTextComponent.text = 'x${game.plData.score.value}';
  }
  void onPlasticChange() {
    plasticTextComponent.text = 'x${game.plData.plastic.value}';
  }
  void onHealthChange() {
    healthTextComponent.text = 'x${game.plData.health.value}';
    if (game.plData.health.value == 0) {
     // AudioManager.stopBgm();
      game.GameOver();
    }
  }
}

