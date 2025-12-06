import 'package:equatable/equatable.dart';
import '../../data/models/quran_audio_model.dart';

enum BottomPlayerStatus { initial, loading, playing, paused, stopped, failure }

class BottomPlayerState extends Equatable {
  final BottomPlayerStatus status;
  final QuranAudioModel? audioData;
  final String? errorMessage;

  const BottomPlayerState({
    this.status = BottomPlayerStatus.initial,
    this.audioData,
    this.errorMessage,
  });

  BottomPlayerState copyWith({
    BottomPlayerStatus? status,
    QuranAudioModel? audioData,
    String? errorMessage,
  }) {
    return BottomPlayerState(
      status: status ?? this.status,
      audioData: audioData ?? this.audioData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, audioData, errorMessage];
}
