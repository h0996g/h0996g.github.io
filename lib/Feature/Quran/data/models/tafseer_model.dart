class TafseerModel {
  final int tafseerId;
  final String tafseerName;
  final String? ayahUrl;
  final int ayahNumber;
  final String text;

  TafseerModel({
    required this.tafseerId,
    required this.tafseerName,
    this.ayahUrl,
    required this.ayahNumber,
    required this.text,
  });

  factory TafseerModel.fromJson(Map<String, dynamic> json) {
    return TafseerModel(
      tafseerId: json['tafseer_id'],
      tafseerName: json['tafseer_name'],
      ayahUrl: json['ayah_url'],
      ayahNumber: json['ayah_number'],
      text: json['text'],
    );
  }
}
