import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Ajr/Core/theme/app_colors.dart';
import 'package:Ajr/Core/helper/overlay_notification_helper.dart';
import '../../../manager/settings_cubit.dart';

class NotificationControlWidget extends StatelessWidget {
  const NotificationControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final intervals = [
      {'label': 'معطل', 'value': 0},
      {'label': '5 دقائق', 'value': 5},
      {'label': '30 دقيقة', 'value': 30},
      {'label': 'ساعة', 'value': 60},
      {'label': '3 ساعات', 'value': 180},
      {'label': '6 ساعات', 'value': 360},
    ];

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.notifications_active, color: AppColors.primary),
              SizedBox(width: 8.w),
              Text(
                'تذكير بالأذكار',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Amiri',
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Notification Type Selector
          Text(
            'نوع الإشعار',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Amiri',
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8.h),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildTypeCard(
                          context,
                          icon: Icons.notifications,
                          label: 'عادي',
                          isSelected:
                              state.notificationType == NotificationType.normal,
                          onTap: () => context
                              .read<SettingsCubit>()
                              .updateNotificationType(NotificationType.normal),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildTypeCard(
                          context,
                          icon: Icons.notification_important,
                          label: 'منبثق',
                          isSelected:
                              state.notificationType ==
                              NotificationType.headsUp,
                          onTap: () async {
                            // Check overlay permission for headsUp type
                            final hasPermission =
                                await OverlayNotificationHelper.checkPermission();
                            if (!hasPermission) {
                              await OverlayNotificationHelper.requestPermission();
                              // Show dialog to inform user
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'يرجى السماح بعرض الإشعارات فوق التطبيقات الأخرى',
                                    ),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            }
                            if (context.mounted) {
                              context
                                  .read<SettingsCubit>()
                                  .updateNotificationType(
                                    NotificationType.headsUp,
                                  );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    state.notificationType == NotificationType.normal
                        ? 'إشعار عادي في شريط الحالة'
                        : 'إشعار منبثق على الشاشة (مثل العائم)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey[600],
                      fontFamily: 'Amiri',
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 16.h),

          // Interval Selector
          Text(
            'الفترة الزمنية',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Amiri',
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8.h),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: intervals.map((interval) {
                  final isSelected =
                      state.notificationIntervalMinutes == interval['value'];
                  return GestureDetector(
                    onTap: () {
                      context.read<SettingsCubit>().updateNotificationInterval(
                        interval['value'] as int,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.grey[300]!,
                        ),
                      ),
                      child: Text(
                        interval['label'] as String,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                          fontFamily: 'Amiri',
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          SizedBox(height: 12.h),
          Text(
            'سيتم إرسال إشعار بذكر حسب الفترة المحددة',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
              fontFamily: 'Amiri',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey[100],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey[300]!,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.grey[700]),
            SizedBox(height: 4.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                fontFamily: 'Amiri',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
