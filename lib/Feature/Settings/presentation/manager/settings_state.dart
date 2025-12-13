part of 'settings_cubit.dart';

enum NotificationType {
  normal, // Normal status bar notification
  bigText, // Expandable notification with full text
  headsUp, // High priority popup notification (like overlay)
}

class SettingsState {
  final double textScaleFactor;
  final int notificationIntervalMinutes; // 0 means disabled
  final NotificationType notificationType;

  // Overlay customization
  final double overlayTextSize;
  final int overlayTextColor; // Color value as int
  final int overlayBackgroundColor; // Color value as int
  final double overlayBackgroundOpacity; // 0.0 to 1.0 (transparency)

  const SettingsState({
    this.textScaleFactor = 1.0,
    this.notificationIntervalMinutes = 0,
    this.notificationType = NotificationType.normal,
    this.overlayTextSize = 18.0,
    this.overlayTextColor = 0xFF000000, // Black
    this.overlayBackgroundColor = 0xFFFFFFFF, // White
    this.overlayBackgroundOpacity = 1.0, // Fully opaque
  });

  SettingsState copyWith({
    double? textScaleFactor,
    int? notificationIntervalMinutes,
    NotificationType? notificationType,
    double? overlayTextSize,
    int? overlayTextColor,
    int? overlayBackgroundColor,
    double? overlayBackgroundOpacity,
  }) {
    return SettingsState(
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      notificationIntervalMinutes:
          notificationIntervalMinutes ?? this.notificationIntervalMinutes,
      notificationType: notificationType ?? this.notificationType,
      overlayTextSize: overlayTextSize ?? this.overlayTextSize,
      overlayTextColor: overlayTextColor ?? this.overlayTextColor,
      overlayBackgroundColor:
          overlayBackgroundColor ?? this.overlayBackgroundColor,
      overlayBackgroundOpacity:
          overlayBackgroundOpacity ?? this.overlayBackgroundOpacity,
    );
  }
}
