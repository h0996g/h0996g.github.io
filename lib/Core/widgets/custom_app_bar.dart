import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Feature/Settings/presentation/manager/settings_cubit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showSettingsAction;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showSettingsAction = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Amiri',
          fontSize: 20.sp,
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.primary,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        if (showSettingsAction)
          IconButton(
            onPressed: () => _showTextSizeSettings(context),
            icon: Icon(
              Icons.text_fields_rounded,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
      ],
    );
  }

  void _showTextSizeSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.text_fields, color: AppColors.primary),
                SizedBox(width: 8.w),
                Text(
                  'حجم النص',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Amiri',
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'صغير',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Amiri',
                            ),
                          ),
                          Text(
                            'افتراضي',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Amiri',
                            ),
                          ),
                          Text(
                            'كبير',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Amiri',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        'بسم الله الرحمن الرحيم',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.sp, fontFamily: 'Amiri'),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
