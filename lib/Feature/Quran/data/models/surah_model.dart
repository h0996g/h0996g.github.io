import 'ayah_model.dart';

class SurahModel {
  final int number;
  final String name;
  final String name2;
  final String revelationType;
  final List<AyahModel> ayahs;

  SurahModel({
    required this.number,
    required this.name,
    required this.name2,
    required this.revelationType,
    required this.ayahs,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      number: json['number'],
      name: json['name'],
      name2: json['name2'],
      revelationType: json['revelationType'],
      ayahs: (json['ayahs'] as List).map((e) => AyahModel.fromJson(e)).toList(),
    );
  }
}
