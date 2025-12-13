import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:noor/Core/api/dio.dart';
import 'package:noor/Core/helper/environment.dart';
import 'package:noor/Core/helper/observer.dart';
import 'package:noor/Core/services/notification_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest_all.dart' as tz;

class AppUtils {
  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize timezone data
    tz.initializeTimeZones();

    // Initialize notification service
    await NotificationService().initialize();

    DioHelper.init();
    Bloc.observer = MyBlocObserver();
    await dotenv.load(fileName: Environment.fileName);

    await Supabase.initialize(
      url: Environment.supabaseUrl,
      anonKey: Environment.supabaseAnonKey,
    );
  }
}
