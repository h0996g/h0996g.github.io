class AppVersionModel {
  final int id;
  final String platform;
  final String latestVersion;
  final String minSupportedVersion;
  final bool forceUpdate;
  final String title;
  final String message;
  final String updateUrl;

  AppVersionModel({
    required this.id,
    required this.platform,
    required this.latestVersion,
    required this.minSupportedVersion,
    required this.forceUpdate,
    required this.title,
    required this.message,
    required this.updateUrl,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) {
    return AppVersionModel(
      id: json['id'] as int,
      platform: json['platform'] as String,
      latestVersion: json['latest_version'] as String,
      minSupportedVersion: json['min_supported_version'] as String,
      forceUpdate: json['force_update'] as bool,
      title: json['title'] as String,
      message: json['message'] as String,
      updateUrl: json['update_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'platform': platform,
      'latest_version': latestVersion,
      'min_supported_version': minSupportedVersion,
      'force_update': forceUpdate,
      'title': title,
      'message': message,
      'update_url': updateUrl,
    };
  }
}
