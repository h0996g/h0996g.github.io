import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/theme/app_colors.dart';
import '../manager/settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('الإعدادات'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
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
            _buildTextSizeControl(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTextSizeControl(BuildContext context) {
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
              Icon(Icons.text_fields, color: AppColors.primary),
              SizedBox(width: 8.w),
              Text(
                'حجم النص',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Amiri',
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Column(
                children: [
                  Slider(
                    value: state.textScaleFactor,
                    min: 0.8,
                    max: 1.5,
                    divisions: 7,
                    label: state.textScaleFactor.toStringAsFixed(1),
                    onChanged: (value) {
                      context.read<SettingsCubit>().updateTextScale(value);
                    },
                    activeColor: AppColors.primary,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'صغير',
                        style: TextStyle(fontSize: 12.sp, fontFamily: 'Amiri'),
                      ),
                      Text(
                        'افتراضي',
                        style: TextStyle(fontSize: 12.sp, fontFamily: 'Amiri'),
                      ),
                      Text(
                        'كبير',
                        style: TextStyle(fontSize: 12.sp, fontFamily: 'Amiri'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      'هذا نص تجريبي لمعاينة الحجم.',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Amiri',
                      ), // Just standard size to show effect
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
