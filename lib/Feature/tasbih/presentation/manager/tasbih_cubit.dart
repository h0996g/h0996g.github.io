import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'tasbih_state.dart';

class TasbihCubit extends Cubit<TasbihState> {
  TasbihCubit() : super(const TasbihState());

  void increment() {
    if (state.count < state.target) {
      final newCount = state.count + 1;
      final isTargetReached = newCount == state.target;

      if (isTargetReached) {
        HapticFeedback.heavyImpact();
        emit(
          state.copyWith(count: newCount, status: TasbihStatus.targetReached),
        );
      } else {
        HapticFeedback.lightImpact();
        emit(state.copyWith(count: newCount, status: TasbihStatus.counting));
      }
    } else {
      // Logic for wrapping around or resetting if user taps after completion
      // For now, let's reset to 1 like the previous implementation logic "wrapped to 1"
      HapticFeedback.lightImpact();
      emit(state.copyWith(count: 1, status: TasbihStatus.counting));
    }
  }

  void reset() {
    HapticFeedback.mediumImpact();
    emit(state.copyWith(count: 0, status: TasbihStatus.initial));
  }

  void setTarget(int target) {
    emit(
      state.copyWith(target: target, count: 0, status: TasbihStatus.initial),
    );
  }

  void changeDhikrIndex(int index) {
    HapticFeedback.lightImpact();
    emit(
      state.copyWith(
        selectedDhikrIndex: index,
        count: 0,
        status: TasbihStatus.initial,
      ),
    );
  }

  void cycleDhikr(int increment) {
    int newIndex = state.selectedDhikrIndex + increment;
    if (newIndex < 0) {
      newIndex = TasbihState.dhikrOptions.length - 1;
    } else if (newIndex >= TasbihState.dhikrOptions.length) {
      newIndex = 0;
    }
    changeDhikrIndex(newIndex);
  }
}
