import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:injectable/injectable.dart';

import '../../logger/logger.dart';
import 'domain/usecases/get_music_state_usecase.dart';
import 'domain/usecases/get_sound_state_usecase.dart';
import 'domain/usecases/save_new_music_state_usecase.dart';
import 'domain/usecases/save_new_sound_state_usecase.dart';

abstract class SoundPlayer {
  Future<void> playShort(String path);
  Future<void> stopShortSound();
  Future<void> pauseShortSound();
  Future<void> resumeShortSound();

  Future<void> playBackgroundMusic(String path, double volume);
  Future<void> stopBackgroundMusic();
  Future<void> pauseBackgroundMusic();
  Future<void> resumeBackgroundMusic();

  Future<void> stopAll();
  Future<void> pauseAll();
  Future<void> resumeAll();

  Future<void> toggleSounds();
  Future<void> toggleMusic();
  Future<bool> isSoundEnabled();
  Future<bool> isMusicEnabled();
}

@Singleton(as: SoundPlayer)
class SoundPlayerImpl implements SoundPlayer {
  final GetSoundStateUsecase _getSoundEnabledStateUsecase;
  final SaveNewSoundStateUsecase _saveNewSoundStateUsecase;
  final GetMusicStateUsecase _getMusicEnabledStateUsecase;
  final SaveNewMusicStateUsecase _saveNewMusicStateUsecase;

  AudioPlayer? shortPlayer;
  AudioPlayer? backgroundPlayer;

  SoundPlayerImpl(
    this._getSoundEnabledStateUsecase,
    this._saveNewSoundStateUsecase,
    this._getMusicEnabledStateUsecase,
    this._saveNewMusicStateUsecase,
  ) {
    AudioPlayer.logEnabled = true;
    init();
  }

  @override
  Future<bool> isSoundEnabled() async =>
      (await _getSoundEnabledStateUsecase()).fold((failure) => true, (state) => state);

  @override
  Future<bool> isMusicEnabled() async =>
      (await _getMusicEnabledStateUsecase()).fold((failure) => true, (state) => state);

  Future<void> init() async {
    shortPlayer = AudioPlayer();
    backgroundPlayer = AudioPlayer();
    final state = await _getSoundEnabledStateUsecase();

    await state.fold((_) => _saveNewSoundStateUsecase(true), (state) {});
  }

  @override
  Future<void> playShort(String path) async {
    var state = await _getSoundEnabledStateUsecase();
    await state.fold((_) {}, (state) {
      stopShortSound();
      playSound(shouldPlay: state, path: path);
    });
  }

  Future<void> playSound({required bool shouldPlay, required String path}) async {
    if (shouldPlay) {
      shortPlayer = await AudioCache().play(path, mode: PlayerMode.LOW_LATENCY);
    }
  }

  @override
  Future<void> toggleSounds() async {
    final state = await _getSoundEnabledStateUsecase();
    await state.fold((_) {}, (state) => _saveNewSoundStateUsecase(!state));
  }

  @override
  Future<void> toggleMusic() async {
    final state = await _getMusicEnabledStateUsecase();
    await state.fold((_) {}, (state) => _saveNewMusicStateUsecase(!state));
  }

  @override
  Future<void> playBackgroundMusic(String path, double volume) async {
    final state = await _getMusicEnabledStateUsecase();
    final isMusicOff = (backgroundPlayer != null && backgroundPlayer?.state != AudioPlayerState.PLAYING);
    await state.fold((_) {}, (state) async {
      if (isMusicOff) {
        backgroundPlayer = await AudioCache().loop(path, volume: volume, mode: PlayerMode.MEDIA_PLAYER);
      } else {
        AppLogger.error("backgroundPlayer error");
      }
    });
  }

  @override
  Future<void> stopBackgroundMusic() async {
    backgroundPlayer?.stop() ?? AppLogger.error("stopBackgroundMusic failed");
  }

  @override
  Future<void> pauseBackgroundMusic() async {
    backgroundPlayer?.pause() ?? AppLogger.error("pauseBackgroundMusic failed");
  }

  @override
  Future<void> resumeBackgroundMusic() async {
    if (await isMusicEnabled()) {
      await backgroundPlayer?.resume() ?? AppLogger.error("resumeBackgroundMusic failed");
    }
  }

  @override
  Future<void> pauseShortSound() async {
    shortPlayer?.pause() ?? AppLogger.error("pauseShortSound failed");
  }

  @override
  Future<void> stopShortSound() async {
    await shortPlayer?.stop() ?? AppLogger.error("stopShortSound failed");
  }

  @override
  Future<void> resumeShortSound() async {
    if (await isSoundEnabled()) {
      await shortPlayer?.resume() ?? AppLogger.error("resumeShortSound failed");
    }
  }

  @override
  Future<void> stopAll() async {
    await stopBackgroundMusic();
    await stopShortSound();
  }

  @override
  Future<void> pauseAll() async {
    await pauseShortSound();
    await pauseBackgroundMusic();
  }

  @override
  Future<void> resumeAll() async {
    await resumeBackgroundMusic();
    await resumeShortSound();
  }
}
