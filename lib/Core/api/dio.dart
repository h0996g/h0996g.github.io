import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHelper {
  static late Dio dio;

  static String get baseUrl {
    // For web, we need to use a CORS proxy to bypass mixed content blocking
    // since api.quran-tafseer.com only supports HTTP
    if (kIsWeb) {
      // Using AllOrigins as a CORS proxy
      return 'https://api.allorigins.win/raw?url=http://api.quran-tafseer.com/tafseer/';
    }
    // For mobile platforms, use direct HTTP
    return 'http://api.quran-tafseer.com/tafseer/';
  }

  static init() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  static Future<Response> getData({
    required url,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {'Content-Type': 'application/json'};
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    dio.options.headers = {'Content-Type': 'application/json'};
    return await dio.post(url, data: data);
  }

  static Future<Response> putData({
    required url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    return await dio.put(url, queryParameters: query, data: data);
  }

  static Future<Response> deleteData({
    required url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    dio.options.headers = {'Content-Type': 'application/json'};
    return await dio.delete(url, queryParameters: query, data: data);
  }
}
