import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    } else {
      return '.env.development';
    }
  }

  static String get supabaseUrl {
    // For web builds, prioritize --dart-define values
    const defineUrl = String.fromEnvironment('SUPABASE_URL');
    if (defineUrl.isNotEmpty) {
      return defineUrl;
    }
    // Fallback to .env file for development
    return dotenv.env['SUPABASE_URL'] ?? 'URL_NOT_FOUND';
  }

  static String get supabaseAnonKey {
    // For web builds, prioritize --dart-define values
    const defineKey = String.fromEnvironment('SUPABASE_ANON_KEY');
    if (defineKey.isNotEmpty) {
      return defineKey;
    }
    // Fallback to .env file for development
    return dotenv.env['SUPABASE_ANON_KEY'] ?? 'URL_NOT_FOUND';
  }
}
