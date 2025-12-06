class AdkarDetailModel {
  final int sectionId;
  final int count;
  final String description;
  final String reference;
  final String content;

  AdkarDetailModel({
    required this.sectionId,
    required this.count,
    required this.description,
    required this.reference,
    required this.content,
  });

  factory AdkarDetailModel.fromJson(Map<String, dynamic> json) {
    return AdkarDetailModel(
      sectionId: json['section_id'] ?? 0,
      count: json['count'] is int
          ? json['count']
          : int.tryParse(json['count'].toString()) ?? 1,
      description: json['description'] ?? '',
      reference: json['reference'] ?? '',
      content: json['content'] ?? '',
    );
  }
}
