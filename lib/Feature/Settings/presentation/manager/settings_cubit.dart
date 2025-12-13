import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noor/Core/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final prefs = await SharedPreferences.getInstance();

      final textScale = prefs.getDouble(_textScaleKey) ?? 1.0;
      final interval = prefs.getInt(_notificationIntervalKey) ?? 0;
      final typeIndex = prefs.getInt(_notificationTypeKey) ?? 0;
      final type = NotificationType.values[typeIndex];
      final overlayTextSize = prefs.getDouble(_overlayTextSizeKey) ?? 18.0;
      final overlayTextColor = prefs.getInt(_overlayTextColorKey) ?? 0xFF000000;
      final overlayBgColor =
          prefs.getInt(_overlayBackgroundColorKey) ?? 0xFFFFFFFF;
      final overlayBgOpacity =
          prefs.getDouble(_overlayBackgroundOpacityKey) ?? 1.0;

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
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_textScaleKey, scale);
  }

  Future<void> updateNotificationInterval(int intervalMinutes) async {
    emit(state.copyWith(notificationIntervalMinutes: intervalMinutes));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_notificationIntervalKey, intervalMinutes);

    await _notificationService.scheduleAdkarNotifications(
      intervalMinutes,
      state.notificationType,
    );
  }

  Future<void> updateNotificationType(NotificationType type) async {
    emit(state.copyWith(notificationType: type));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_notificationTypeKey, type.index);

    // Reschedule notifications with new type if interval is active
    if (state.notificationIntervalMinutes > 0) {
      await _notificationService.scheduleAdkarNotifications(
        state.notificationIntervalMinutes,
        type,
      );
    }
  }

  Future<void> updateOverlayTextSize(double size) async {
    emit(state.copyWith(overlayTextSize: size));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_overlayTextSizeKey, size);
  }

  Future<void> updateOverlayTextColor(int color) async {
    emit(state.copyWith(overlayTextColor: color));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_overlayTextColorKey, color);
  }

  Future<void> updateOverlayBackgroundColor(int color) async {
    emit(state.copyWith(overlayBackgroundColor: color));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_overlayBackgroundColorKey, color);
  }

  Future<void> updateOverlayBackgroundOpacity(double opacity) async {
    emit(state.copyWith(overlayBackgroundOpacity: opacity));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_overlayBackgroundOpacityKey, opacity);
  }
}
