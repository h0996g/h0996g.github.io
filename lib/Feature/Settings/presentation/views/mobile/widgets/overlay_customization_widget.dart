import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Ajr/Core/theme/app_colors.dart';
import '../../../manager/settings_cubit.dart';
import 'color_picker_widget.dart';

class OverlayCustomizationWidget extends StatelessWidget {
  const OverlayCustomizationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        // Only show if bigText or headsUp type is selected
        if (state.notificationType == NotificationType.normal) {
          return const SizedBox.shrink();
        }

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
                  Icon(Icons.tune, color: AppColors.primary),
                  SizedBox(width: 8.w),
                  Text(
                    'تخصيص الإشعار',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Amiri',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Live Preview
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(
                    state.overlayBackgroundColor,
                  ).withOpacity(state.overlayBackgroundOpacity),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey[300]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'ذكر',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontFamily: 'Amiri',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: state.overlayTextSize,
                        height: 1.8,
                        color: Color(state.overlayTextColor),
                        fontFamily: 'Amiri',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Text Size Slider
              Text(
                'حجم النص',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Amiri',
                  color: Colors.grey[700],
                ),
              ),
              Slider(
                value: state.overlayTextSize,
                min: 12.0,
                max: 32.0,
                divisions: 20,
                label: state.overlayTextSize.toStringAsFixed(0),
                activeColor: AppColors.primary,
                onChanged: (value) {
                  context.read<SettingsCubit>().updateOverlayTextSize(value);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '12',
                    style: TextStyle(fontSize: 10.sp, fontFamily: 'Amiri'),
                  ),
                  Text(
                    '32',
                    style: TextStyle(fontSize: 10.sp, fontFamily: 'Amiri'),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Opacity Slider
              Text(
                'شفافية الخلفية',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Amiri',
                  color: Colors.grey[700],
                ),
              ),
              Slider(
                value: state.overlayBackgroundOpacity,
                min: 0.3,
                max: 1.0,
                divisions: 14,
                label: '${(state.overlayBackgroundOpacity * 100).toInt()}%',
                activeColor: AppColors.primary,
                onChanged: (value) {
                  context.read<SettingsCubit>().updateOverlayBackgroundOpacity(
                    value,
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'شفاف',
                    style: TextStyle(fontSize: 10.sp, fontFamily: 'Amiri'),
                  ),
                  Text(
                    'غير شفاف',
                    style: TextStyle(fontSize: 10.sp, fontFamily: 'Amiri'),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Color Pickers
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'لون النص',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Amiri',
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        ColorPickerWidget(
                          currentColor: Color(state.overlayTextColor),
                          onColorSelected: (color) {
                            context
                                .read<SettingsCubit>()
                                .updateOverlayTextColor(color.value);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'لون الخلفية',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Amiri',
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        ColorPickerWidget(
                          currentColor: Color(state.overlayBackgroundColor),
                          onColorSelected: (color) {
                            context
                                .read<SettingsCubit>()
                                .updateOverlayBackgroundColor(color.value);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
