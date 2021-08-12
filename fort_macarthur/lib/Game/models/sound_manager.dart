import 'package:just_audio/just_audio.dart';

// for ui sounds only
enum SoundFx {
  uiConfirm,
  uiCancel,
  uiLocked
  // put soundfx index here
}

// ui sound manager
class SoundManager {
  // all sound effects of the game
  static List<GameSoundEffect> sounds = [];

  static void init() {
    // ui confirm sound
    sounds.add(GameSoundEffect(
      soundPath: "assets/sounds/uiConfirmSound.wav",
    ));

    // ui cancel sound
    sounds.add(GameSoundEffect(
      soundPath: "assets/sounds/uiCancelSound.wav",
    ));

    // ui locked sound
    sounds.add(GameSoundEffect(
      soundPath: "assets/sounds/uiLockedSound.wav",
    ));
  }

  static void play(SoundFx soundIndex) {
    sounds.elementAt(soundIndex.index).playUi();
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
      player.setLoopMode(LoopMode.one);
    } else {
      player.setLoopMode(LoopMode.off);
    }
  }

  bool isPlaying() {
    return player.playing;
  }

  // bool reachedEnd() {
  //   return player.position.inSeconds >= player.duration!.inSeconds;
  // }

  void play() {
    player.play();
  }

  // if the sound is a UI sound, use this
  void playUi() async {
    await player.play();
    stop();
  }

  void pause() {
    player.pause();
  }

  void stop() {
    player.stop();
    player.seek(Duration.zero);
  }

  void dispose() {
    player.dispose();
  }
}
