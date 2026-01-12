import 'package:flutter/services.dart';

class OverlayNotificationHelper {
  static const MethodChannel _channel = MethodChannel('overlay_notification');

  /// Check if overlay permission is granted
  static Future<bool> checkPermission() async {
    try {
      final bool hasPermission = await _channel.invokeMethod('checkPermission');
      return hasPermission;
    } catch (e) {
      print('Error checking overlay permission: $e');
      return false;
    }
  }

  /// Request overlay permission
  static Future<void> requestPermission() async {
    try {
      await _channel.invokeMethod('requestPermission');
    } catch (e) {
      print('Error requesting overlay permission: $e');
    }
  }

  /// Show custom overlay notification
  static Future<void> showOverlay({
    required String adkarText,
    double textSize = 18.0,
    int textColor = 0xFF000000,
    int backgroundColor = 0xFFFFFFFF,
  }) async {
    try {
      await _channel.invokeMethod('showOverlay', {
        'adkar_text': adkarText,
        'text_size': textSize,
        'text_color': textColor,
        'background_color': backgroundColor,
      });
    } catch (e) {
      print('Error showing overlay: $e');
    }
  }

  /// Start the native Kotlin scheduler (foreground service)
  static Future<void> startScheduler(int intervalMinutes) async {
    try {
      await _channel.invokeMethod('startScheduler', {
        'interval_minutes': intervalMinutes,
      });
    } catch (e) {
      print('Error starting scheduler: $e');
    }
  }

  /// Stop the native Kotlin scheduler
  static Future<void> stopScheduler() async {
    try {
      await _channel.invokeMethod('stopScheduler');
    } catch (e) {
      print('Error stopping scheduler: $e');
    }
  }

  /// Update overlay settings in real-time
  static Future<void> updateSettings() async {
    try {
      await _channel.invokeMethod('updateSettings');
    } catch (e) {
      print('Error updating settings: $e');
    }
  }
}
