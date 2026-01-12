import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:Ajr/Feature/Adkar/data/repo/adkar_repo.dart';
import 'package:Ajr/Feature/Adkar/data/models/adkar_detail_model.dart';
import 'package:Ajr/Feature/Settings/presentation/manager/settings_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Ajr/Core/helper/overlay_notification_helper.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  final AdkarRepository _adkarRepository = AdkarRepository();

  // Notification channel ID
  static const String _normalChannelId = 'adkar_normal';

  Future<void> initialize() async {
    // Android notification channels
    const AndroidNotificationChannel normalChannel = AndroidNotificationChannel(
      _normalChannelId,
      'أذكار عادية',
      description: 'إشعارات الأذكار العادية',
      importance: Importance.defaultImportance,
      enableVibration: true,
      playSound: true,
    );

    // Create channel
    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(normalChannel);

    // Initialize notifications
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Request permissions
    await _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  void _onNotificationTapped(NotificationResponse response) {
    print('Notification tapped: ${response.payload}');
  }

  Future<void> scheduleAdkarNotifications(
    int intervalMinutes,
    NotificationType type,
  ) async {
    // Cancel all existing notifications
    await cancelAllNotifications();

    if (intervalMinutes == 0) {
      return;
    }

    // Save settings for native code to read
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('notification_interval', intervalMinutes);
    await prefs.setInt('notification_type', type.index);

    // Only start foreground service for headsUp type (overlay notifications)
    // For normal and bigText, stop the foreground service
    if (type == NotificationType.headsUp) {
      await OverlayNotificationHelper.startScheduler(intervalMinutes);
    } else {
      await OverlayNotificationHelper.stopScheduler();
    }

    // Show immediate notification
    await showRandomAdkarNotification();
  }

  Future<void> showRandomAdkarNotification() async {
    try {
      final adkar = await _getRandomAdkar();
      if (adkar == null) return;

      // Get notification type from preferences
      final prefs = await SharedPreferences.getInstance();
      final typeIndex = prefs.getInt('notification_type') ?? 0;
      final type = NotificationType.values[typeIndex];

      // Only load overlay customization settings for headsUp type
      if (type == NotificationType.headsUp) {
        final overlayTextSize = prefs.getDouble('overlay_text_size') ?? 18.0;
        final overlayTextColor =
            prefs.getInt('overlay_text_color') ?? 0xFF000000;
        final overlayBgColor =
            prefs.getInt('overlay_background_color') ?? 0xFFFFFFFF;
        final overlayBgOpacity =
            prefs.getDouble('overlay_background_opacity') ?? 1.0;

        // Apply opacity to background color
        final bgColorWithOpacity = Color(
          overlayBgColor,
        ).withOpacity(overlayBgOpacity).value;

        await _showNotification(
          adkar.content,
          type,
          textSize: overlayTextSize,
          textColor: overlayTextColor,
          backgroundColor: bgColorWithOpacity,
        );
      } else {
        // For normal and bigText types, use default values
        await _showNotification(adkar.content, type);
      }
    } catch (e) {
      print('Error showing notification: $e');
    }
  }

  Future<void> _showNotification(
    String adkarText,
    NotificationType type, {
    double textSize = 18.0,
    int textColor = 0xFF000000,
    int backgroundColor = 0xFFFFFFFF,
  }) async {
    switch (type) {
      case NotificationType.normal:
        await _showStandardNotification(
          adkarText,
          _normalChannelId,
          Importance.defaultImportance,
        );
        break;

      case NotificationType.headsUp:
        // Use custom overlay for headsUp type
        await OverlayNotificationHelper.showOverlay(
          adkarText: adkarText,
          textSize: textSize,
          textColor: textColor,
          backgroundColor: backgroundColor,
        );
        break;
    }
  }

  Future<void> _showStandardNotification(
    String adkarText,
    String channelId,
    Importance importance,
  ) async {
    final int notificationId = Random().nextInt(100000);

    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          channelId,
          'أذكار',
          importance: importance,
          priority: Priority.defaultPriority,
          showWhen: true,
          icon: '@mipmap/ic_launcher',
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      notificationId,
      '🌙 ذكر',
      adkarText,
      notificationDetails,
    );
  }

  Future<AdkarDetailModel?> _getRandomAdkar() async {
    try {
      // Get all sections
      final sections = await _adkarRepository.getSections();
      if (sections.isEmpty) return null;

      // Pick a random section
      final randomSection = sections[Random().nextInt(sections.length)];

      // Get details for that section
      final details = await _adkarRepository.getSectionDetails(
        randomSection.id,
      );
      if (details.isEmpty) return null;

      // Filter to get only short adkar (less than 150 characters)
      final shortAdkar = details
          .where((adkar) => adkar.content.length < 150)
          .toList();

      // If no short adkar found, use all adkar
      final adkarList = shortAdkar.isNotEmpty ? shortAdkar : details;

      // Pick a random adkar from the filtered list
      return adkarList[Random().nextInt(adkarList.length)];
    } catch (e) {
      print('Error getting random adkar: $e');
      return null;
    }
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
    await OverlayNotificationHelper.stopScheduler();
  }
}
