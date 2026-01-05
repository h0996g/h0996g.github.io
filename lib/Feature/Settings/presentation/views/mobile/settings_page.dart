import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Ajr/Core/theme/app_colors.dart';
import 'package:Ajr/Core/widgets/appbar/mobile/custom_app_bar.dart';
import 'widgets/text_size_control_widget.dart';
import 'widgets/notification_control_widget.dart';
import 'widgets/overlay_customization_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBar(title: 'الإعدادات'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مظهر التطبيق',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontFamily: 'Amiri',
                ),
              ),
              SizedBox(height: 16.h),
              const TextSizeControlWidget(),
              SizedBox(height: 24.h),
              Text(
                'الإشعارات',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontFamily: 'Amiri',
                ),
              ),
              SizedBox(height: 16.h),
              const NotificationControlWidget(),
              SizedBox(height: 24.h),
              const OverlayCustomizationWidget(),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
