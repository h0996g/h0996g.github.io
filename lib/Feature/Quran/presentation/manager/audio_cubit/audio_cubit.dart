import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  final AudioPlayer _audioPlayer;

  AudioCubit() : _audioPlayer = AudioPlayer(), super(const AudioState()) {
    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        emit(state.copyWith(status: AudioStatus.stopped, currentAyahId: null));
      }
    });
  }

  Future<void> playAudio(String url, int ayahId) async {
    try {
      if (state.currentAyahId == ayahId && _audioPlayer.playing) {
        await _audioPlayer.pause();
        emit(state.copyWith(status: AudioStatus.paused, currentAyahId: ayahId));
      } else if (state.currentAyahId == ayahId &&
          !_audioPlayer.playing &&
          state.status == AudioStatus.paused) {
        emit(
          state.copyWith(status: AudioStatus.playing, currentAyahId: ayahId),
        );
        await _audioPlayer.play();
      } else {
        // New audio or restarting stopped audio
        emit(
          state.copyWith(status: AudioStatus.loading, currentAyahId: ayahId),
        );
        if (_audioPlayer.playing) {
          await _audioPlayer.stop();
        }
        await _audioPlayer.setUrl(url);
        emit(
          state.copyWith(status: AudioStatus.playing, currentAyahId: ayahId),
        );
        await _audioPlayer.play();
      }
    } catch (e) {
      emit(
        state.copyWith(status: AudioStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    emit(state.copyWith(status: AudioStatus.stopped, currentAyahId: null));
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
