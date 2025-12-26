import 'dart:io';
import 'package:noor/Core/models/app_version_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum UpdateType { none, optional, force }

class VersionCheckResult {
  final UpdateType updateType;
  final AppVersionModel? versionInfo;

  VersionCheckResult({required this.updateType, this.versionInfo});
}

class VersionCheckService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Check if app update is available
  Future<VersionCheckResult> checkForUpdate() async {
    try {
      // Get current platform
      final platform = _getCurrentPlatform();

      // Get current app version
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      // Query Supabase for version info
      final response = await _supabase
          .from('app_update_config')
          .select()
          .eq('platform', platform)
          .single();

      final versionInfo = AppVersionModel.fromJson(response);

      // Compare versions
      final updateType = _determineUpdateType(
        currentVersion: currentVersion,
        latestVersion: versionInfo.latestVersion,
        minSupportedVersion: versionInfo.minSupportedVersion,
        forceUpdate: versionInfo.forceUpdate,
      );

      return VersionCheckResult(
        updateType: updateType,
        versionInfo: updateType != UpdateType.none ? versionInfo : null,
      );
    } catch (e) {
      print('Error checking for update: $e');
      return VersionCheckResult(updateType: UpdateType.none);
    }
  }

  /// Get current platform name matching Supabase format
  String _getCurrentPlatform() {
    if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isIOS) {
      return 'ios';
    }
    return 'Unknown';
  }

  /// Determine what type of update is needed
  UpdateType _determineUpdateType({
    required String currentVersion,
    required String latestVersion,
    required String minSupportedVersion,
    required bool forceUpdate,
  }) {
    // Check if current version is below minimum supported version
    if (_isVersionLower(currentVersion, minSupportedVersion)) {
      return UpdateType.force;
    }

    // Check if force update flag is set and newer version is available
    if (forceUpdate && _isVersionLower(currentVersion, latestVersion)) {
      return UpdateType.force;
    }

    // Check if optional update is available
    if (_isVersionLower(currentVersion, latestVersion)) {
      return UpdateType.optional;
    }

    return UpdateType.none;
  }

  /// Compare two version strings (e.g., "1.0.0" vs "1.0.1")
  /// Returns true if version1 < version2
  bool _isVersionLower(String version1, String version2) {
    try {
      final v1Parts = version1.split('.').map(int.parse).toList();
      final v2Parts = version2.split('.').map(int.parse).toList();

      // Ensure both have same length by padding with zeros
      while (v1Parts.length < v2Parts.length) {
        v1Parts.add(0);
      }
      while (v2Parts.length < v1Parts.length) {
        v2Parts.add(0);
      }

      // Compare each part
      for (int i = 0; i < v1Parts.length; i++) {
        if (v1Parts[i] < v2Parts[i]) {
          return true;
        } else if (v1Parts[i] > v2Parts[i]) {
          return false;
        }
      }

      return false; // Versions are equal
    } catch (e) {
      print('Error comparing versions: $e');
      return false;
    }
  }
}
