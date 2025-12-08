part of 'settings_cubit.dart';

class SettingsState {
  final double textScaleFactor;

  const SettingsState({this.textScaleFactor = 1.0});

  SettingsState copyWith({double? textScaleFactor}) {
    return SettingsState(
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
    );
  }
}
