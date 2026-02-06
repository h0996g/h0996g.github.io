import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:Ajr/Core/api/dio.dart';
import 'package:Ajr/Core/helper/cache_helper.dart';
import 'package:Ajr/Core/helper/environment.dart';
import 'package:Ajr/Core/helper/observer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest_all.dart' as tz;

class AppUtils {
  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize timezone data
    tz.initializeTimeZones();

    // Initialize cache helper
    await CacheHelper.init();

    // Note: Notification service will be initialized only when user enables notifications
    // This happens in the notification permission dialog

    DioHelper.init();
    Bloc.observer = MyBlocObserver();

    // Try to load .env file (for development)
    // In production web builds, we use --dart-define instead
    // Skip dotenv loading for web in release mode to avoid 404 errors
    if (!kIsWeb || !kReleaseMode) {
      try {
        await dotenv.load(fileName: Environment.fileName);
      } catch (e) {
        debugPrint('dotenv file not found, using --dart-define values: $e');
      }
    }

    await Supabase.initialize(
      url: Environment.supabaseUrl,
      anonKey: Environment.supabaseAnonKey,
    );
  }
}
