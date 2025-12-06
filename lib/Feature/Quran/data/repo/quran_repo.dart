import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../Core/api/dio.dart';
import '../models/surah_model.dart';
import '../models/tafseer_model.dart';
import 'package:dio/dio.dart';

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

  Future<TafseerModel> getTafseer({
    required int surahNumber,
    required int ayahNumber,
    int tafseerId = 1, // Default to Al-Muyassar
  }) async {
    try {
      final Response response = await DioHelper.getData(
        url: '$tafseerId/$surahNumber/$ayahNumber',
      );
      return TafseerModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load Tafseer: $e');
    }
  }
}
