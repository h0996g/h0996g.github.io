import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:noor/Feature/Home/data/repo/home_repo.dart';
import 'package:noor/Feature/Home/presentation/manager/bottom_player_state.dart';

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
