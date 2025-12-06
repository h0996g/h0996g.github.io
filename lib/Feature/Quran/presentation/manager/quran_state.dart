import '../../data/models/surah_model.dart';

enum QuranStatus { initial, loading, success, failure }

class QuranState {
  final QuranStatus status;
  final List<SurahModel> surahs;
  final String? errorMessage;

  const QuranState({
    this.status = QuranStatus.initial,
    this.surahs = const [],
    this.errorMessage,
  });

  QuranState copyWith({
    QuranStatus? status,
    List<SurahModel>? surahs,
    String? errorMessage,
  }) {
    return QuranState(
      status: status ?? this.status,
      surahs: surahs ?? this.surahs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
