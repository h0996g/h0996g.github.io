class AyahModel {
  final int number;
  final String text;
  final int numberInSurah;
  final int juz;
  final int page;
  final bool sajda;

  AyahModel({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.page,
    required this.sajda,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      number: json['number'],
      text: json['text'],
      numberInSurah: json['numberInSurah'],
      juz: json['juz'],
      page: json['page'],
      sajda: json['sajda'] is bool ? json['sajda'] : false,
    );
  }
}
