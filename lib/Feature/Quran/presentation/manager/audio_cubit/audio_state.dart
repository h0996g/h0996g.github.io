import 'package:equatable/equatable.dart';

enum AudioStatus { initial, loading, playing, paused, stopped, failure }

class AudioState extends Equatable {
  final AudioStatus status;
  final int? currentAyahId;
  final String? errorMessage;

  const AudioState({
    this.status = AudioStatus.initial,
    this.currentAyahId,
    this.errorMessage,
  });

  AudioState copyWith({
    AudioStatus? status,
    int? currentAyahId,
    String? errorMessage,
  }) {
    return AudioState(
      status: status ?? this.status,
      currentAyahId: currentAyahId ?? this.currentAyahId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, currentAyahId, errorMessage];

  @override
  String toString() {
    return 'AudioState(status: $status, currentAyahId: $currentAyahId, errorMessage: $errorMessage)';
  }
}
