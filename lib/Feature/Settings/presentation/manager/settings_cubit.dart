import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void updateTextScale(double scale) {
    emit(state.copyWith(textScaleFactor: scale));
  }
}
