import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences cache;

  static Future<void> init() async {
    cache = await SharedPreferences.getInstance();
  }

  static Future<bool> putCache({
    required String key,
    required dynamic value,
  }) async {
    if (value is bool) {
      return await cache.setBool(key, value);
    } else if (value is String) {
      return await cache.setString(key, value);
    } else if (value is int) {
      return await cache.setInt(key, value);
    } else if (value is double) {
      return await cache.setDouble(key, value);
    } else if (value is List<String>) {
      return await cache.setStringList(key, value);
    }
    return false;
  }

  static dynamic getData({required String key}) {
    return cache.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await cache.remove(key);
  }

  static Future<bool> clearAll() async {
    return await cache.clear();
  }
}
