class QuranAudioModel {
  final int? id;
  final String? url;
  final DateTime? timestamp;

  QuranAudioModel({this.id, this.url, this.timestamp});

  factory QuranAudioModel.fromJson(Map<String, dynamic> json) {
    return QuranAudioModel(
      id: json['id'],
      url: json['url'],
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : null,
    );
  }
}
