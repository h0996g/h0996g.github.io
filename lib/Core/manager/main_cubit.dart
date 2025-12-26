import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noor/Core/helper/cache_helper.dart';
import 'package:noor/Core/routing/app_router.dart';
import 'package:noor/Core/widgets/notification_permission_dialog.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  static const String _hasShownDialogKey = 'has_shown_notification_dialog';
  static const String _notificationsEnabledKey = 'notifications_enabled';

  MainCubit() : super(const MainState()) {
    _loadState();
  }

  Future<void> _loadState() async {
    try {
      final hasShown =
          CacheHelper.getData(key: _hasShownDialogKey) as bool? ?? false;
      final enabled =
          CacheHelper.getData(key: _notificationsEnabledKey) as bool? ?? false;

      emit(
        MainState(
          hasShownNotificationDialog: hasShown,
          notificationsEnabled: enabled,
        ),
      );
    } catch (e) {
      print('Error loading main state: $e');
    }
  }

  Future<void> markNotificationDialogAsShown() async {
    emit(state.copyWith(hasShownNotificationDialog: true));
    await CacheHelper.putCache(key: _hasShownDialogKey, value: true);
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    emit(state.copyWith(notificationsEnabled: enabled));
    await CacheHelper.putCache(key: _notificationsEnabledKey, value: enabled);
  }

  bool shouldShowNotificationDialog() {
    return !state.hasShownNotificationDialog;
  }

  /// Show notification permission dialog using global navigator
  void showNotificationDialogIfNeeded() {
    if (shouldShowNotificationDialog()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          final context = navigatorKey.currentContext;
          if (context != null && context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const NotificationPermissionDialog(),
            );
          }
        });
      });
    }
  }
}
