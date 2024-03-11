import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../utils/constants.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ever_green/game/game.dart';

class BootScreen extends StatefulWidget {
  final bool isLoading;
  const BootScreen({super.key, required this.isLoading});

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
                        'A Game by Team Mugy',
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
              secondChild: widget.isLoading
                  ? CircularProgressIndicator() // Show
                  :  TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const GameWidget.controlled(gameFactory: MyGame.new),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, // Text color
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min, // Use Min to prevent the Row from expanding to the max
                  children: <Widget>[
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0), // Add some spacing between icon and text
                      child: Text(
                        'Start the Engine', // The text you want to display
                        style: TextStyle(
                          color: Colors.white, // Text color
                        ),
                      ),
                    ),
                  ],
                ),
              ),



            );
          },
        ),
      ),
    );
  }
}
