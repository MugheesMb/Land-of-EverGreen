import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gitlab_hero/game/game.dart';
import 'package:gitlab_hero/routes/boot_screen.dart';



void main() async {
/*  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "rexlia"
      ),
      home: GameWidget.controlled(gameFactory: MyGame.new),
    );
  }
}

