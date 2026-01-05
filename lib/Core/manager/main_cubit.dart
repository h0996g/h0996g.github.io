import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Ajr/Core/helper/cache_helper.dart';
import 'package:Ajr/Core/routing/app_router.dart';
import 'package:Ajr/Core/widgets/notification_permission_dialog.dart';
import 'package:Ajr/Core/widgets/app_update_dialog.dart';
import 'package:Ajr/Core/services/version_check_service.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  static const String _hasShownDialogKey = 'has_shown_notification_dialog';
  static const String _notificationsEnabledKey = 'notifications_enabled';

  final VersionCheckService _versionCheckService = VersionCheckService();

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
    // Don't show notification dialog in browser
    if (kIsWeb) {
      return;
    }

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

  /// Check app version and show update dialog if needed
  void checkAppVersionAndShowDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1000), () async {
        final result = await _versionCheckService.checkForUpdate();

        if (result.updateType != UpdateType.none &&
            result.versionInfo != null) {
          final context = navigatorKey.currentContext;
          if (context != null && context.mounted) {
            print('result.updateType${result.updateType}');
            print('result.versionInfo${result.versionInfo}');
            showDialog(
              context: context,
              barrierDismissible: result.updateType != UpdateType.force,
              builder: (context) => AppUpdateDialog(
                versionInfo: result.versionInfo!,
                isForceUpdate: result.updateType == UpdateType.force,
              ),
            );
          }
        }
      });
    });
  }
}
