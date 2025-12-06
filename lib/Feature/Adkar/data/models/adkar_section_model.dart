class AdkarSectionModel {
  final int id;
  final String name;

  AdkarSectionModel({required this.id, required this.name});

  factory AdkarSectionModel.fromJson(Map<String, dynamic> json) {
    return AdkarSectionModel(id: json['id'], name: json['name']);
  }
}
