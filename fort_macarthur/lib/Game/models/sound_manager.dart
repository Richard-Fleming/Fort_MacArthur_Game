import 'package:audioplayers/audioplayers.dart';

enum SoundFx {
  test,
  // put soundfx index here
}

class SoundManager {
  // all sound effects of the game
  static List<GameSoundEffect> sounds = [];

  static void init() {
    sounds.add(GameSoundEffect(
      soundPath: "https://bit.ly/2CH50TO",
      loop: true,
    ));
  }

  static void play(SoundFx soundIndex) {
    sounds.elementAt(soundIndex.index).play();
  }

  static void pause(SoundFx soundIndex) {
    sounds.elementAt(soundIndex.index).pause();
  }

  static void resume(SoundFx soundIndex) {
    sounds.elementAt(soundIndex.index).resume();
  }

  static void stop(SoundFx soundIndex) {
    sounds.elementAt(soundIndex.index).stop();
  }

  static void releaseAll() {
    for (var sound in sounds) {
      sound.release();
    }
  }

  static void disposeAll() {
    for (var sound in sounds) {
      sound.dispose();
    }
  }
}

class GameSoundEffect {
  AudioPlayer player = new AudioPlayer();

  String soundPath;
  bool loop;

  GameSoundEffect({required this.soundPath, this.loop = false}) {
    if (loop) {
      player.setReleaseMode(ReleaseMode.LOOP);
    }
  }

  void play({double volume = 1.0}) {
    player.play(soundPath, volume: volume);
  }

  void pause() {
    player.pause();
  }

  void resume() {
    player.resume();
  }

  void stop() {
    player.stop();
  }

  void release() {
    player.release();
  }

  void dispose() {
    player.dispose();
  }
}
