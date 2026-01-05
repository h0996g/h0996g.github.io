import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:Ajr/Feature/Home/data/repo/home_repo.dart';
import 'package:Ajr/Feature/Home/presentation/manager/bottom_player_state.dart';
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
    if (state.historyIndex < state.history.length - 1) {
      final newIndex = state.historyIndex + 1;
      emit(state.copyWith(historyIndex: newIndex));
      await _loadAndPlayAudio(state.history[newIndex]);
    } else {
      await playRandomAyah();
    }
  }

  Future<void> playPrevious() async {
    if (state.historyIndex > 0) {
      final newIndex = state.historyIndex - 1;
      emit(state.copyWith(historyIndex: newIndex));
      await _loadAndPlayAudio(state.history[newIndex]);
    }
  }

  Future<void> playRandomAyah() async {
    final randomId = Random().nextInt(100) + 1; // 1 to 100
    await playQuranAudio(randomId);
  }

  Future<void> playQuranAudio(int id) async {
    // Logic to update history when a new specific Ayah is played (random or manual)
    if (state.status == BottomPlayerStatus.playing &&
        state.audioData?.id == id) {
      await _audioPlayer.pause();
      emit(state.copyWith(status: BottomPlayerStatus.paused));
      return;
    }

    if (state.status == BottomPlayerStatus.paused &&
        state.audioData?.id == id) {
      emit(state.copyWith(status: BottomPlayerStatus.playing));
      await _audioPlayer.play();
      return;
    }

    // Determine new history
    final currentHistory = state.historyIndex >= 0
        ? state.history.sublist(0, state.historyIndex + 1)
        : <int>[];

    final newHistory = List<int>.from(currentHistory)..add(id);
    final newIndex = newHistory.length - 1;

    emit(state.copyWith(history: newHistory, historyIndex: newIndex));

    await _loadAndPlayAudio(id);
  }

  Future<void> _loadAndPlayAudio(int id) async {
    try {
      emit(state.copyWith(status: BottomPlayerStatus.loading));

      final audioData = await repository.getQuranAudio(id);

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
