part of 'main_cubit.dart';

class MainState {
  final bool hasShownNotificationDialog;
  final bool notificationsEnabled;

  const MainState({
    this.hasShownNotificationDialog = false,
    this.notificationsEnabled = false,
  });

  MainState copyWith({
    bool? hasShownNotificationDialog,
    bool? notificationsEnabled,
  }) {
    return MainState(
      hasShownNotificationDialog:
          hasShownNotificationDialog ?? this.hasShownNotificationDialog,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}
