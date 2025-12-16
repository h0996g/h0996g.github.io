import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noor/Feature/Quran/presentation/manager/tafseer_cubit/tafseer_state.dart';
import '../../../data/repo/quran_repo.dart';

class TafseerCubit extends Cubit<TafseerState> {
  final QuranRepository quranRepository;

  TafseerCubit(this.quranRepository) : super(const TafseerState());

  Future<void> fetchTafseer({
    required int surahNumber,
    required int ayahNumber,
  }) async {
    emit(state.copyWith(status: TafseerStatus.loading));
    try {
      final tafseer = await quranRepository.getTafseer(
        surahNumber: surahNumber,
        ayahNumber: ayahNumber,
      );
      emit(state.copyWith(status: TafseerStatus.success, tafseer: tafseer));
    } catch (e) {
      emit(
        state.copyWith(
          status: TafseerStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
