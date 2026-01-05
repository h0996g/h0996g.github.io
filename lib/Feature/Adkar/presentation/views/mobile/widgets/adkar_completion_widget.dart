import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Ajr/Core/theme/app_colors.dart';
import 'package:Ajr/Feature/Home/presentation/views/mobile/widgets/bottom_player_widget.dart';

class AdkarCompletionWidget extends StatelessWidget {
  const AdkarCompletionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              size: 80.sp,
              color: AppColors.primary,
            ),
            SizedBox(height: 16.h),
            Text(
              'تم الانتهاء من الأذكار',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Amiri',
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'تقبل الله منا ومنكم صالح الأعمال',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
            ),
            SizedBox(height: 40.h),
            const BottomPlayerWidget(),
          ],
        ),
      ),
    );
  }
}
