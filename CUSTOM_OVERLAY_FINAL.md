# Custom Overlay Notification - Final Implementation

## ✨ Overview

A **native Android custom overlay notification** system that displays Adkar as a floating card on top of any app.

---

## 🎯 Features

- ✅ **Floating overlay** - Appears on top of all apps
- ✅ **Tap to dismiss** - Close by tapping anywhere on the card
- ✅ **Auto-dismiss** - Automatically closes after 10 seconds
- ✅ **Short Adkar only** - Shows only Adkar with less than 150 characters
- ✅ **Fully customizable** - Text size, text color, background color, and transparency
- ✅ **Background execution** - Works when app is closed
- ✅ **Minimal design** - Clean, simple, beautiful

---

## 📱 How It Works

### User Flow:

1. User opens **Settings** (الإعدادات)
2. Selects **"منبثق"** (HeadsUp) notification type
3. Grants **overlay permission** when prompted
4. Sets **notification interval** (15 min, 30 min, etc.)
5. Customizes appearance (optional):
   - Text size (12-32)
   - Text color (12 options)
   - Background color (12 options)
   - **Background transparency** (30%-100%)
6. Overlay appears at set intervals!

### Technical Flow:

```
AndroidAlarmManager schedules periodic task
         ↓
Every X minutes → Background callback
         ↓
Get random SHORT Adkar (< 150 chars)
         ↓
Check notification type
         ↓
If headsUp → Show custom overlay
         ↓
MethodChannel → Native Android
         ↓
OverlayNotificationService creates overlay
         ↓
Display floating card on screen
         ↓
User taps OR 10 seconds → Dismiss
```

---

## 🏗️ Architecture

### Native Android (Kotlin):

- **OverlayNotificationService.kt** - Creates and displays overlay window
- **OverlayPlugin.kt** - Flutter ↔ Android bridge via MethodChannel
- **overlay_notification.xml** - Minimal card layout (icon + text)
- **overlay_background.xml** - Rounded corners drawable

### Flutter (Dart):

- **overlay_notification_helper.dart** - Dart API for native calls
- **notification_service.dart** - Handles all notification logic
  - Filters for short Adkar only
  - Applies opacity to background color
  - Shows custom overlay for headsUp type
- **settings_cubit.dart** - Manages user preferences
- **settings_state.dart** - State with opacity support
- **settings_page.dart** - UI with sliders and color pickers

---

## 🎨 Design

### Overlay Appearance:

```
┌────────────────────────┐
│       🌙 ذكر          │
│                        │
│   [Short Adkar Text]   │
│                        │
└────────────────────────┘
```

**Specifications:**

- **Size**: Compact, minimal padding
- **Corner radius**: 20dp (smooth, modern)
- **Border**: 0.5dp light gray
- **Elevation**: 12dp shadow
- **Position**: Top-center of screen
- **Transparency**: Adjustable (30%-100%)

---

## ⚙️ Configuration

### AndroidManifest.xml:

```xml
<!-- Required permissions -->
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>

<!-- Services -->
<service android:name=".OverlayNotificationService" />

<!-- AndroidAlarmManager -->
<service android:name="dev.fluttercommunity.plus.androidalarmmanager.AlarmService" />
<receiver android:name="dev.fluttercommunity.plus.androidalarmmanager.AlarmBroadcastReceiver" />
```

### Dependencies (pubspec.yaml):

```yaml
dependencies:
  flutter_local_notifications: ^19.5.0
  android_alarm_manager_plus: ^4.0.3
  shared_preferences: ^2.5.3
```

---

## 🔧 Key Implementation Details

### 1. Short Adkar Filter:

```dart
// Only show Adkar with less than 150 characters
final shortAdkar = details.where((adkar) => adkar.content.length < 150).toList();
final adkarList = shortAdkar.isNotEmpty ? shortAdkar : details;
```

### 2. Opacity Support:

```dart
// Apply opacity to background color
final bgColorWithOpacity = Color(overlayBgColor).withOpacity(overlayBgOpacity).value;
```

### 3. Tap to Dismiss:

```kotlin
// Close on tap anywhere on the card
cardView?.isClickable = true
cardView?.isFocusable = true
cardView?.setOnClickListener {
    removeOverlay()
    stopSelf()
}
```

### 4. Transparency in Native:

```kotlin
// GradientDrawable supports alpha channel
val drawable = GradientDrawable()
drawable.setColor(backgroundColor) // Includes alpha from Flutter
```

---

## 📝 Files Structure

```
android/app/src/main/
├── kotlin/com/example/noor/
│   ├── MainActivity.kt (registers plugin)
│   ├── OverlayNotificationService.kt
│   └── OverlayPlugin.kt
└── res/
    ├── layout/
    │   └── overlay_notification.xml
    └── drawable/
        └── overlay_background.xml

lib/
├── Core/
│   ├── helper/
│   │   └── overlay_notification_helper.dart
│   └── services/
│       └── notification_service.dart
└── Feature/Settings/
    └── presentation/
        ├── manager/
        │   ├── settings_cubit.dart
        │   └── settings_state.dart
        └── views/
            └── settings_page.dart
```

---

## 🧪 Testing Checklist

- [x] Overlay appears when interval is set
- [x] Shows only short Adkar (< 150 chars)
- [x] Tap anywhere to dismiss works
- [x] Auto-dismiss after 10 seconds works
- [x] Text size customization works
- [x] Text color customization works
- [x] Background color customization works
- [x] **Background transparency works** (30%-100%)
- [x] Live preview shows all changes
- [x] Works when app is minimized
- [x] Works when app is closed
- [x] Permission request works
- [x] Persists after device reboot

---

## 🎉 Summary

This implementation provides a **clean, minimal, and fully customizable** overlay notification system that:

1. ✅ Shows **only short, readable Adkar**
2. ✅ Has a **beautiful, compact design**
3. ✅ Supports **full transparency control**
4. ✅ Works **in background** and when **app is closed**
5. ✅ Is **easy to dismiss** (tap anywhere)
6. ✅ Uses **native Android** for reliability

**No unnecessary code. No bloat. Just what's needed.** 🚀
