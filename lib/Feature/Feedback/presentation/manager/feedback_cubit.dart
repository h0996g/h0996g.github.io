import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  final SupabaseClient _supabaseClient;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  FeedbackCubit(this._supabaseClient) : super(const FeedbackState());

  Future<void> submitFeedback({
    required String text,
    required FeedbackMethod method,
    String? contactInfo,
    XFile? attachment,
  }) async {
    if (text.trim().isEmpty && attachment == null) {
      emit(
        state.copyWith(
          status: FeedbackStatus.error,
          message: "Please add a description or attachment.",
        ),
      );
      return;
    }

    if (method != FeedbackMethod.anonymous &&
        (contactInfo == null || contactInfo.trim().isEmpty)) {
      emit(
        state.copyWith(
          status: FeedbackStatus.error,
          message: "Please provide your contact information.",
        ),
      );
      return;
    }

    emit(state.copyWith(status: FeedbackStatus.loading));

    try {
      // Collect Device Info
      final Map<String, dynamic> deviceInfo = await _getDeviceInfo();

      String? attachmentUrl;

      if (attachment != null) {
        final bytes = await attachment.readAsBytes();
        final fileExt = attachment.path.split('.').last;
        final fileName =
            '${DateTime.now().toIso8601String()}_feedback.$fileExt';

        // Ensure bucket exists or handle error - assuming 'feedback_attachments'
        await _supabaseClient.storage
            .from('feedback_attachments')
            .uploadBinary(fileName, bytes);

        // Supabase v2 returns string path on success (sometimes) or throws.
        // Get public URL
        attachmentUrl = _supabaseClient.storage
            .from('feedback_attachments')
            .getPublicUrl(fileName);
      }

      await _supabaseClient.from('feedback').insert({
        'description': text,
        'attachment_url': attachmentUrl,
        'created_at': DateTime.now().toIso8601String(),
        'is_anonymous': method == FeedbackMethod.anonymous,
        'contact_method': method.name,
        'contact_info': contactInfo,
        'device_info': deviceInfo,
      });

      emit(
        state.copyWith(
          status: FeedbackStatus.success,
          message: "Feedback sent successfully. Thank you!",
        ),
      );
    } catch (e) {
      // If table/bucket doesn't exist, this will fail.
      // User must configure Supabase.
      emit(
        state.copyWith(
          status: FeedbackStatus.error,
          message: "Failed to send feedback: ${e.toString()}",
        ),
      );
    }
  }

  Future<Map<String, dynamic>> _getDeviceInfo() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final Map<String, dynamic> info = {
        'app_version': packageInfo.version,
        'build_number': packageInfo.buildNumber,
        'platform': Platform.operatingSystem,
      };

      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        info.addAll({
          'device': androidInfo.device,
          'manufacturer': androidInfo.manufacturer,
          'model': androidInfo.model,
          'android_version': androidInfo.version.release,
          'sdk_int': androidInfo.version.sdkInt,
        });
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        info.addAll({
          'device': iosInfo.name,
          'model': iosInfo.model,
          'system_name': iosInfo.systemName,
          'system_version': iosInfo.systemVersion,
          'utsname': iosInfo.utsname.machine,
        });
      }
      return info;
    } catch (e) {
      return {'error': 'Failed to get device info: $e'};
    }
  }
}
