import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/name_of_allah_model.dart';

class NamesOfAllahRepository {
  Future<List<NameOfAllahModel>> getNames() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/db/Names_Of_Allah/Names_Of_Allah.json',
      );
      final List<dynamic> data = json.decode(response);
      return data.map((json) => NameOfAllahModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load Names of Allah: $e');
    }
  }
}
