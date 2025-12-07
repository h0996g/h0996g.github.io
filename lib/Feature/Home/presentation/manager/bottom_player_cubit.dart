import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:noor/Feature/Home/data/repo/home_repo.dart';
import 'package:noor/Feature/Home/presentation/manager/bottom_player_state.dart';
import 'dart:math';

class BottomPlayerCubit extends Cubit<BottomPlayerState> {
  final HomeRepository repository;
  final AudioPlayer _audioPlayer;

  BottomPlayerCubit(this.repository)
    : _audioPlayer = AudioPlayer(),
      super(const BottomPlayerState()) {
    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        emit(state.copyWith(status: BottomPlayerStatus.stopped));
      }
    });

    _audioPlayer.positionStream.listen((position) {
      // Only emit if the second has changed to avoid excessive rebuilds
      if (position.inSeconds != state.position.inSeconds) {
        emit(state.copyWith(position: position));
      }
    });

    _audioPlayer.durationStream.listen((duration) {
      emit(state.copyWith(duration: duration ?? Duration.zero));
    });
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  Future<void> replay() async {
    await _audioPlayer.seek(Duration.zero);
    if (!_audioPlayer.playing) {
      _audioPlayer.play();
      emit(state.copyWith(status: BottomPlayerStatus.playing));
    }
  }

  Future<void> playNext() async {
    if (state.audioData?.id != null) {
      // Loop or Clamp? Let's assume loop 1-100 as per user context
      int nextId = state.audioData!.id! + 1;
      if (nextId > 100) nextId = 1;
      await playQuranAudio(nextId);
    }
  }

  Future<void> playPrevious() async {
    if (state.audioData?.id != null) {
      int prevId = state.audioData!.id! - 1;
      if (prevId < 1) prevId = 100;
      await playQuranAudio(prevId);
    }
  }

  Future<void> playRandomAyah() async {
    final randomId = Random().nextInt(100) + 1; // 1 to 100
    await playQuranAudio(randomId);
  }

  Future<void> playQuranAudio(int id) async {
    try {
      // If already playing the requested ID (assuming currently loaded audio is for this ID)
      if (state.status == BottomPlayerStatus.playing &&
          state.audioData?.id == id) {
        await _audioPlayer.pause();
        emit(state.copyWith(status: BottomPlayerStatus.paused));
        return;
      }

      // If paused and same ID, resume
      if (state.status == BottomPlayerStatus.paused &&
          state.audioData?.id == id) {
        emit(state.copyWith(status: BottomPlayerStatus.playing));
        await _audioPlayer.play();
        return;
      }

      emit(state.copyWith(status: BottomPlayerStatus.loading));

      // Fetch URL if strictly new ID or no data (simple case: always fetch for now as req implies id=1 always for now)
      // Optimisation: check if we already have data for this ID to avoid re-fetch, but user wants to play it.
      // Let's fetch to be safe as per requirements.
      final audioData = await repository.getQuranAudio(id);

      // Stop current if playing? built-in setUrl handles it usually but safe to stop.
      if (_audioPlayer.playing) {
        await _audioPlayer.stop();
      }

      await _audioPlayer.setUrl(audioData.url ?? '');

      emit(
        state.copyWith(
          status: BottomPlayerStatus.playing,
          audioData: audioData,
        ),
      );

      await _audioPlayer.play();
    } catch (e) {
      emit(
        state.copyWith(
          status: BottomPlayerStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
