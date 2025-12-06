import 'package:noor/Feature/Quran/data/models/tafseer_model.dart';

enum TafseerStatus { initial, loading, success, failure }

class TafseerState {
  final TafseerStatus status;
  final TafseerModel? tafseer;
  final String? errorMessage;

  const TafseerState({
    this.status = TafseerStatus.initial,
    this.tafseer,
    this.errorMessage,
  });

  TafseerState copyWith({
    TafseerStatus? status,
    TafseerModel? tafseer,
    String? errorMessage,
  }) {
    return TafseerState(
      status: status ?? this.status,
      tafseer: tafseer ?? this.tafseer,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
