/*
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

// This class is responsible for playing all the sound effects
// and background music in this game.
class AudioManager {
  static final sfx = ValueNotifier(true);
  static final bgm = ValueNotifier(true);

  static Future<void> init() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([

     musics files
    ]);

    final sfxFiles = ['collect.wav', 'jump.wav', 'hurt.wav'];
    for (final sfxFile in sfxFiles) {
      await FlameAudio.play(sfxFile, volume: 0.0);
    }
  }

  static void playSfx(String file) {
    if (sfx.value) {
      FlameAudio.play(file, volume: 0.6);
    }
  }

  static void playBgm(String file) {
    if (bgm.value) {
      FlameAudio.bgm.play(file, volume: 0.5);
    }
  }

  static void pauseBgm() {
    FlameAudio.bgm.pause();
  }

  static void resumeBgm() {
    if (bgm.value) {
      FlameAudio.bgm.resume();
    }
  }

  static void stopBgm() {
    FlameAudio.bgm.stop();
  }
}
*/
