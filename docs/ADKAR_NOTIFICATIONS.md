# Adkar Notifications Feature

## Overview

This feature allows users to receive periodic notifications with random Adkar (Islamic remembrances) at configurable intervals.

## Implementation Details

### Components Added:

1. **NotificationService** (`lib/Core/services/notification_service.dart`)

   - Singleton service managing local notifications
   - Schedules random Adkar notifications
   - Handles notification permissions for both Android and iOS

2. **Settings State & Cubit Updates**

   - Added `notificationIntervalMinutes` to `SettingsState`
   - Added `updateNotificationInterval()` method to `SettingsCubit`

3. **Settings Page UI**
   - Added notification interval selector with options:
     - معطل (Disabled)
     - 5 دقائق (5 minutes)
     - 30 دقيقة (30 minutes)
     - ساعة (1 hour)
     - 3 ساعات (3 hours)
     - 6 ساعات (6 hours)

### Packages Added:

- `flutter_local_notifications`: ^19.5.0
- `timezone`: ^0.10.1

### Permissions:

**Android** (AndroidManifest.xml):

- POST_NOTIFICATIONS
- SCHEDULE_EXACT_ALARM
- USE_EXACT_ALARM
- RECEIVE_BOOT_COMPLETED
- VIBRATE
- WAKE_LOCK

**iOS**: Handled automatically by flutter_local_notifications

### How It Works:

1. User selects a notification interval in Settings
2. `SettingsCubit.updateNotificationInterval()` is called
3. `NotificationService.scheduleAdkarNotifications()` is triggered
4. Service fetches random Adkar from local JSON files
5. Notifications are scheduled for the next 24 hours (up to 50 notifications)
6. Each notification displays a random Adkar content

### Notification Scheduling:

- Uses exact alarm scheduling for precise timing
- Schedules multiple notifications in advance (up to 24 hours)
- Automatically cancels previous notifications when interval changes
- Uses Africa/Cairo timezone (can be customized)

### Future Enhancements:

- Persist notification settings using shared_preferences
- Add notification sound customization
- Add notification time range (e.g., only during day hours)
- Add specific Adkar categories selection
- Implement background service for continuous scheduling beyond 24 hours
