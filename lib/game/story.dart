import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'game.dart';

class SceneShowcase extends StatefulWidget {

  static const id  = 'SceneShowcase';
  final VoidCallback onGameStart;
  final MyGame gameRef;
  SceneShowcase( {required this.onGameStart , required this.gameRef});

  @override
  _SceneShowcaseState createState() => _SceneShowcaseState();
}

class _SceneShowcaseState extends State<SceneShowcase> {
  final List<String> _scenes = [
    'assets/images/m1.gif',
    'assets/images/m2.gif',
    'assets/images/m3.gif',
    // Add more paths to your asset GIFs here
  ];
  final List<String> _texts = [
    '"Once upon a time, Evergreen was the heartbeat of nature, a symphony of green melodies.',
    'But one day, a villain named Dr. Wasteland decided to play a different tune. Plastic confetti rained down, turning our lively Evergreen into a silent, plastic maze.',
    'After plastics invasion, Evergreen fell silent. But I believe we can revive its melody. Will you join the Green Awakening?',
    // Add more descriptions here
  ];
  int _currentIndex = 0;
  bool _showStartButton = false;
  Timer? _timer;
  String _animatedText = '';
  Timer? _textAnimationTimer;
  AudioPlayer? _bgMusic;

  @override
  void initState() {
    super.initState();
    // if(widget.gameRef.musicValueNotifier.value) {
    //   FlameAudio.loopLongAudio(MyGame.storyM, volume: 0.6).then((audioPlayer) {
    //     _bgMusic = audioPlayer;
    //   });
    // }
    _startSceneShowcase();
    _animateText(_texts[_currentIndex]);
  }


  void _startSceneShowcase() {
    _timer = Timer(Duration(seconds: 7), () {
      if (_currentIndex < _scenes.length - 1) {
        setState(() {
          _currentIndex++;
          _animatedText = ''; // Reset animated text for the new scene
        });
        _animateText(_texts[_currentIndex]);
        _startSceneShowcase();
      } else {
        _showButton();
      }
    });
  }

  void _animateText(String text) {
    int index = 0;
    _textAnimationTimer?.cancel(); // Cancel any existing timer
    _textAnimationTimer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (index < text.length) {
        setState(() {
          _animatedText += text[index];
        });
        index++;
      } else {
        _textAnimationTimer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    //_bgMusic?.dispose();
    _timer?.cancel();

    _textAnimationTimer?.cancel();
    super.dispose();
  }

  void _showButton() {
    setState(() {
      _showStartButton = true;
    });
  }

  void _skipShowcase() {
    _timer?.cancel();
    _showButton();
  }
  void _startGame() {
    widget.onGameStart(); // Invoke the callback when the "Start Game" button is pressed.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 1000),
              child: _showStartButton
                  ? ElevatedButton(
                key: ValueKey('startButton'),
                onPressed: _startGame,
                child: Image.asset("assets/images/go.png"),
              )
                  : Image.asset(
                _scenes[_currentIndex],
                key: ValueKey(_scenes[_currentIndex]),
              ),
            ),
          ),
          Positioned(
            bottom: 100.0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                child: Text(
                  !_showStartButton ? _animatedText : '',
                  key: ValueKey<int>(_currentIndex), // Change key to _currentIndex for the text animation restart
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          ),
          if (!_showStartButton) // Only show the Skip button if the Start Game button isn't showing
            Positioned(
              bottom: 20.0,
              right: 20.0,
              child: SizedBox(
                width: 200,
                child: InkWell(
                  onTap: _skipShowcase,
                  child: Image.asset("assets/images/skip.png"),
                ),
              ),
            ),
        ],
      ),
    );
  }
}