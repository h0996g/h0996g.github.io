import 'package:equatable/equatable.dart';
import '../../data/models/quran_audio_model.dart';

enum BottomPlayerStatus { initial, loading, playing, paused, stopped, failure }

class BottomPlayerState extends Equatable {
  final BottomPlayerStatus status;
  final QuranAudioModel? audioData;
  final String? errorMessage;
  final Duration position;
  final Duration duration;

  const BottomPlayerState({
    this.status = BottomPlayerStatus.initial,
    this.audioData,
    this.errorMessage,
    this.position = Duration.zero,
    this.duration = Duration.zero,
  });

  BottomPlayerState copyWith({
    BottomPlayerStatus? status,
    QuranAudioModel? audioData,
    String? errorMessage,
    Duration? position,
    Duration? duration,
  }) {
    return BottomPlayerState(
      status: status ?? this.status,
      audioData: audioData ?? this.audioData,
      errorMessage: errorMessage ?? this.errorMessage,
      position: position ?? this.position,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object?> get props => [
    status,
    audioData,
    errorMessage,
    position,
    duration,
  ];
}
