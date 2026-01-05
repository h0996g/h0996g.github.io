import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:Ajr/Core/manager/main_cubit.dart';
import 'package:Ajr/Core/theme/app_colors.dart';
import 'package:Ajr/Core/routing/app_router.dart';
import 'package:Ajr/Core/helper/overlay_notification_helper.dart';
import 'package:Ajr/Core/services/notification_service.dart';
import 'package:Ajr/Feature/Settings/presentation/manager/settings_cubit.dart';

class NotificationPermissionDialog extends StatefulWidget {
  const NotificationPermissionDialog({super.key});

  @override
  State<NotificationPermissionDialog> createState() =>
      _NotificationPermissionDialogState();
}

class _NotificationPermissionDialogState
    extends State<NotificationPermissionDialog> {
  bool _showTypeSelection = false;
  NotificationType? _selectedType;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    _showTypeSelection ? 'اختر نوع الإشعار' : 'تفعيل التنبيهات',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: _showTypeSelection
                  ? _buildTypeSelectionContent()
                  : _buildInitialContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialContent() {
    return Column(
      children: [
        const Text(
          'احصل على تذكيرات يومية للأذكار والأدعية',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Color(0xFF333333), height: 1.5),
        ),
        const SizedBox(height: 20),

        // Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _handleLater(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'لاحقاً',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () => _showTypeSelectionStep(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'تفعيل الآن',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeSelectionContent() {
    return Column(
      children: [
        // Notification type options
        _buildNotificationTypeOption(
          type: NotificationType.normal,
          title: 'إشعار عادي',
          description: 'تنبيه بسيط في شريط الحالة',
          emoji: '🔔',
        ),
        const SizedBox(height: 10),
        _buildNotificationTypeOption(
          type: NotificationType.bigText,
          title: 'إشعار موسع',
          description: 'عرض النص كاملاً',
          emoji: '📱',
        ),
        const SizedBox(height: 10),
        _buildNotificationTypeOption(
          type: NotificationType.headsUp,
          title: 'إشعار منبثق',
          description: 'ظهور فوري على الشاشة',
          emoji: '✨',
        ),

        const SizedBox(height: 20),

        // Action buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _showTypeSelection = false;
                    _selectedType = null;
                  });
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'رجوع',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _selectedType != null
                    ? () => _handleConfirmType(context)
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'تأكيد',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Settings link
        TextButton(
          onPressed: () => _handleGoToSettings(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.settings_outlined, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                'إعدادات متقدمة',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationTypeOption({
    required NotificationType type,
    required String title,
    required String description,
    required String emoji,
  }) {
    final isSelected = _selectedType == type;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedType = type;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade200,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            // Emoji
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.3)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(emoji, style: const TextStyle(fontSize: 22)),
            ),
            const SizedBox(width: 12),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected
                          ? Colors.white.withOpacity(0.9)
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            // Selection indicator
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Colors.white : Colors.grey.shade400,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  void _showTypeSelectionStep() {
    setState(() {
      _showTypeSelection = true;
    });
  }

  void _handleConfirmType(BuildContext context) async {
    if (_selectedType == null) return;

    final mainCubit = context.read<MainCubit>();
    final settingsCubit = context.read<SettingsCubit>();

    // If headsUp type is selected, check overlay permission
    if (_selectedType == NotificationType.headsUp) {
      final hasPermission = await OverlayNotificationHelper.checkPermission();

      if (!hasPermission && context.mounted) {
        final shouldRequest = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'إذن مطلوب',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'للإشعارات المنبثقة، نحتاج إلى إذن "العرض فوق التطبيقات الأخرى".\n\n'
              'سيتم فتح إعدادات النظام، يرجى تفعيل الإذن ثم العودة.',
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.5),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'إلغاء',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('فتح الإعدادات'),
              ),
            ],
          ),
        );

        if (shouldRequest == true) {
          await OverlayNotificationHelper.requestPermission();

          if (context.mounted) {
            final permissionGranted = await showDialog<bool>(
              context: context,
              barrierDismissible: false,
              builder: (dialogContext) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: const Text(
                  'في انتظار الإذن',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: AppColors.primary),
                    SizedBox(height: 16),
                    Text(
                      'يرجى تفعيل الإذن ثم الضغط على "تم"',
                      textAlign: TextAlign.center,
                      style: TextStyle(height: 1.5),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                    child: const Text(
                      'إلغاء',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final granted =
                          await OverlayNotificationHelper.checkPermission();
                      Navigator.of(dialogContext).pop(granted);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('تم'),
                  ),
                ],
              ),
            );

            if (permissionGranted != true && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'لم يتم منح الإذن. يمكنك تفعيله لاحقاً من الإعدادات.',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
              await mainCubit.markNotificationDialogAsShown();
              if (context.mounted) Navigator.of(context).pop();
              return;
            }
          }
        } else {
          return;
        }
      }
    }

    // Initialize notification service
    await NotificationService().initialize();

    // Save preferences
    await mainCubit.markNotificationDialogAsShown();
    await mainCubit.setNotificationsEnabled(true);
    await settingsCubit.updateNotificationType(_selectedType!);
    await settingsCubit.updateNotificationInterval(60);

    if (context.mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تم تفعيل التنبيهات بنجاح! ✓',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _handleGoToSettings(BuildContext context) async {
    final mainCubit = context.read<MainCubit>();

    await NotificationService().initialize();
    await mainCubit.markNotificationDialogAsShown();
    await mainCubit.setNotificationsEnabled(true);

    if (context.mounted) {
      Navigator.of(context).pop();
      context.push(AppRouter.kSettings);
    }
  }

  void _handleLater(BuildContext context) async {
    final mainCubit = context.read<MainCubit>();
    await mainCubit.markNotificationDialogAsShown();
    await mainCubit.setNotificationsEnabled(false);

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
