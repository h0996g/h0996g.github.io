import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/names_of_allah_repo.dart';
import 'names_of_allah_state.dart';

class NamesOfAllahCubit extends Cubit<NamesOfAllahState> {
  final NamesOfAllahRepository repository;

  NamesOfAllahCubit(this.repository) : super(const NamesOfAllahState());

  Future<void> loadNames() async {
    emit(state.copyWith(status: NamesOfAllahStatus.loading));
    try {
      final names = await repository.getNames();
      emit(state.copyWith(status: NamesOfAllahStatus.success, names: names));
    } catch (e) {
      emit(
        state.copyWith(
          status: NamesOfAllahStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
