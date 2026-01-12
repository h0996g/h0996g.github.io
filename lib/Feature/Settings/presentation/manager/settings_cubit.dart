import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Ajr/Core/helper/cache_helper.dart';
import 'package:Ajr/Core/services/notification_service.dart';
import 'package:Ajr/Core/helper/overlay_notification_helper.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final NotificationService _notificationService = NotificationService();
  static const String _textScaleKey = 'text_scale_factor';
  static const String _notificationIntervalKey = 'notification_interval';
  static const String _notificationTypeKey = 'notification_type';
  static const String _overlayTextSizeKey = 'overlay_text_size';
  static const String _overlayTextColorKey = 'overlay_text_color';
  static const String _overlayBackgroundColorKey = 'overlay_background_color';
  static const String _overlayBackgroundOpacityKey =
      'overlay_background_opacity';

  SettingsCubit() : super(const SettingsState()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final textScale =
          CacheHelper.getData(key: _textScaleKey) as double? ?? 1.0;
      final interval =
          CacheHelper.getData(key: _notificationIntervalKey) as int? ?? 0;
      final typeIndex =
          CacheHelper.getData(key: _notificationTypeKey) as int? ?? 0;
      final type = NotificationType.values[typeIndex];
      final overlayTextSize =
          CacheHelper.getData(key: _overlayTextSizeKey) as double? ?? 18.0;
      final overlayTextColor =
          CacheHelper.getData(key: _overlayTextColorKey) as int? ?? 0xFF000000;
      final overlayBgColor =
          CacheHelper.getData(key: _overlayBackgroundColorKey) as int? ??
          0xFFFFFFFF;
      final overlayBgOpacity =
          CacheHelper.getData(key: _overlayBackgroundOpacityKey) as double? ??
          1.0;

      emit(
        SettingsState(
          textScaleFactor: textScale,
          notificationIntervalMinutes: interval,
          notificationType: type,
          overlayTextSize: overlayTextSize,
          overlayTextColor: overlayTextColor,
          overlayBackgroundColor: overlayBgColor,
          overlayBackgroundOpacity: overlayBgOpacity,
        ),
      );

      // Reschedule notifications if interval is active
      if (interval > 0) {
        await _notificationService.scheduleAdkarNotifications(interval, type);
      }
    } catch (e) {
      print('Error loading settings: $e');
    }
  }

  Future<void> updateTextScale(double scale) async {
    emit(state.copyWith(textScaleFactor: scale));
    await CacheHelper.putCache(key: _textScaleKey, value: scale);
  }

  Future<void> updateNotificationInterval(int intervalMinutes) async {
    emit(state.copyWith(notificationIntervalMinutes: intervalMinutes));
    await CacheHelper.putCache(
      key: _notificationIntervalKey,
      value: intervalMinutes,
    );

    // If enabling notifications (interval > 0), ensure we have permission
    if (intervalMinutes > 0) {
      // Initialize notification service (this will request permission if needed)
      await _notificationService.initialize();
    }

    await _notificationService.scheduleAdkarNotifications(
      intervalMinutes,
      state.notificationType,
    );
  }

  Future<void> updateNotificationType(NotificationType type) async {
    emit(state.copyWith(notificationType: type));
    await CacheHelper.putCache(key: _notificationTypeKey, value: type.index);

    // Reschedule notifications with new type if interval is active
    if (state.notificationIntervalMinutes > 0) {
      // Ensure we have notification permission
      await _notificationService.initialize();

      await _notificationService.scheduleAdkarNotifications(
        state.notificationIntervalMinutes,
        type,
      );
    }
  }

  Future<void> updateOverlayTextSize(double size) async {
    emit(state.copyWith(overlayTextSize: size));
    await CacheHelper.putCache(key: _overlayTextSizeKey, value: size);
    // Update overlay in real-time if headsUp type is active
    if (state.notificationType == NotificationType.headsUp) {
      await OverlayNotificationHelper.updateSettings();
    }
  }

  Future<void> updateOverlayTextColor(int color) async {
    emit(state.copyWith(overlayTextColor: color));
    await CacheHelper.putCache(key: _overlayTextColorKey, value: color);
    // Update overlay in real-time if headsUp type is active
    if (state.notificationType == NotificationType.headsUp) {
      await OverlayNotificationHelper.updateSettings();
    }
  }

  Future<void> updateOverlayBackgroundColor(int color) async {
    emit(state.copyWith(overlayBackgroundColor: color));
    await CacheHelper.putCache(key: _overlayBackgroundColorKey, value: color);
    // Update overlay in real-time if headsUp type is active
    if (state.notificationType == NotificationType.headsUp) {
      await OverlayNotificationHelper.updateSettings();
    }
  }

  Future<void> updateOverlayBackgroundOpacity(double opacity) async {
    emit(state.copyWith(overlayBackgroundOpacity: opacity));
    await CacheHelper.putCache(
      key: _overlayBackgroundOpacityKey,
      value: opacity,
    );
    // Update overlay in real-time if headsUp type is active
    if (state.notificationType == NotificationType.headsUp) {
      await OverlayNotificationHelper.updateSettings();
    }
  }
}
