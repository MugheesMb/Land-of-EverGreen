import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../utils/constants.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gitlab_hero/game/game.dart';

class BootScreen extends StatefulWidget {
  const BootScreen({super.key});

  @override
  State<BootScreen> createState() => _BootScreenState();
}

class _BootScreenState extends State<BootScreen> {
  final state = ValueNotifier(CrossFadeState.showFirst);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255,0,0,0),
      body: Center(
        child: ValueListenableBuilder<CrossFadeState>(
          valueListenable: state,
          builder: (context, value, child) {
            return AnimatedCrossFade(
              crossFadeState: state.value,
              duration: const Duration(seconds: 1),
              firstChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText(
                        'A game by Team Mugy',
                        textStyle: TextStyles.buttonSmall,
                      ),
                      RotateAnimatedText(
                        'Powered by Flame Engine',
                        textStyle: TextStyles.buttonSmall,
                      ),
                    ],
                    displayFullTextOnTap: true,
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 100),
                    onFinished: () => state.value = CrossFadeState.showSecond,
                  ),
                ],
              ),
              secondChild: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const GameWidget.controlled(gameFactory: MyGame.new),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.black,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
