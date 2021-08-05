import 'package:just_audio/just_audio.dart';

enum SoundFx {
  test,
  missileLaunch,
  plane,
  explosion,
  uiConfirm,
  uiCancel,
  uiLocked
  // put soundfx index here
}

class SoundManager {
  // all sound effects of the game
  static List<GameSoundEffect> sounds = [];

  static void init() {
    sounds.add(GameSoundEffect(
      soundPath: "assets/sounds/explosionSound.wav",
      loop: true,
    ));
  }

  static void play(SoundFx soundIndex) {
    sounds.elementAt(soundIndex.index).play();
  }

  static void pause(SoundFx soundIndex) {
    sounds.elementAt(soundIndex.index).pause();
  }

  static void stop(SoundFx soundIndex) {
    sounds.elementAt(soundIndex.index).stop();
  }

  static void stopAll() {
    for (var sound in sounds) {
      if (sound.isPlaying()) {
        sound.stop();
      }
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

  GameSoundEffect({
    required this.soundPath,
    this.loop = false,
    double volume = 1.0,
  }) {
    player.setAsset(soundPath);
    player.setVolume(volume);

    if (loop) {
      player.setLoopMode(LoopMode.all);
    } else {
      player.setLoopMode(LoopMode.off);
    }
  }

  bool isPlaying() {
    return player.playing;
  }

  void play() {
    player.play();
  }

  void pause() {
    player.pause();
  }

  void stop() {
    player.stop();
  }

  void dispose() {
    player.dispose();
  }
}
