class NameOfAllahModel {
  final int id;
  final String name;
  final String text;

  NameOfAllahModel({required this.id, required this.name, required this.text});

  factory NameOfAllahModel.fromJson(Map<String, dynamic> json) {
    return NameOfAllahModel(
      id: json['id'],
      name: json['name'],
      text: json['text'],
    );
  }
}
