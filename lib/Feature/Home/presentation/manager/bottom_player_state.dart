import 'package:equatable/equatable.dart';
import '../../data/models/quran_audio_model.dart';

enum BottomPlayerStatus { initial, loading, playing, paused, stopped, failure }

class BottomPlayerState extends Equatable {
  final BottomPlayerStatus status;
  final QuranAudioModel? audioData;
  final String? errorMessage;
  final List<int> history;
  final int historyIndex;
  final Duration position;
  final Duration duration;

  const BottomPlayerState({
    this.status = BottomPlayerStatus.initial,
    this.audioData,
    this.errorMessage,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.history = const [],
    this.historyIndex = -1,
  });

  BottomPlayerState copyWith({
    BottomPlayerStatus? status,
    QuranAudioModel? audioData,
    String? errorMessage,
    Duration? position,
    Duration? duration,
    List<int>? history,
    int? historyIndex,
  }) {
    return BottomPlayerState(
      status: status ?? this.status,
      audioData: audioData ?? this.audioData,
      errorMessage: errorMessage ?? this.errorMessage,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      history: history ?? this.history,
      historyIndex: historyIndex ?? this.historyIndex,
    );
  }

  @override
  List<Object?> get props => [
    status,
    audioData,
    errorMessage,
    history,
    historyIndex,
    position,
    duration,
  ];
}
