import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Ajr/Feature/Adkar/data/repo/adkar_repo.dart';
import 'adkar_state.dart';

class AdkarCubit extends Cubit<AdkarState> {
  final AdkarRepository adkarRepository;

  AdkarCubit(this.adkarRepository) : super(const AdkarState());

  Future<void> loadSections() async {
    emit(state.copyWith(status: AdkarStatus.loading));
    try {
      final sections = await adkarRepository.getSections();
      emit(state.copyWith(status: AdkarStatus.success, sections: sections));
    } catch (e) {
      emit(
        state.copyWith(status: AdkarStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> loadSectionDetails(int sectionId) async {
    emit(state.copyWith(status: AdkarStatus.loading));
    try {
      final details = await adkarRepository.getSectionDetails(sectionId);
      emit(state.copyWith(status: AdkarStatus.success, details: details));
    } catch (e) {
      emit(
        state.copyWith(status: AdkarStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
