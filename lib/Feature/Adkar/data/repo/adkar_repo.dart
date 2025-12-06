import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/adkar_section_model.dart';
import '../models/adkar_detail_model.dart';

class AdkarRepository {
  Future<List<AdkarSectionModel>> getSections() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/db/section.json',
      );
      final List<dynamic> data = json.decode(response);
      return data.map((json) => AdkarSectionModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load sections: $e');
    }
  }

  Future<List<AdkarDetailModel>> getSectionDetails(int sectionId) async {
    try {
      final String response = await rootBundle.loadString(
        'assets/db/sectionDetails.json',
      );
      final List<dynamic> data = json.decode(response);
      return data
          .map((json) => AdkarDetailModel.fromJson(json))
          .where((element) => element.sectionId == sectionId)
          .toList();
    } catch (e) {
      throw Exception('Failed to load details: $e');
    }
  }
}
