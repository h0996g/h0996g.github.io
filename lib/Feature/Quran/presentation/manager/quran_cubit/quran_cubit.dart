import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repo/quran_repo.dart';
import 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  final QuranRepository quranRepository;

  QuranCubit(this.quranRepository) : super(const QuranState());

  Future<void> loadQuranData() async {
    emit(state.copyWith(status: QuranStatus.loading));
    try {
      final surahs = await quranRepository.getSurahs();
      emit(state.copyWith(status: QuranStatus.success, surahs: surahs));
    } catch (e) {
      emit(
        state.copyWith(status: QuranStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
