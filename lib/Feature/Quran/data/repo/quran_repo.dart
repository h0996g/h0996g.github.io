import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/surah_model.dart';

class QuranRepository {
  Future<List<SurahModel>> getSurahs() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/db/quran/quranapi.json',
      );
      final List<dynamic> data = json.decode(response);
      return data.map((json) => SurahModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load Quran data: $e');
    }
  }
}
