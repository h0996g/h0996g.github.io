import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../Core/theme/app_colors.dart';

class BottomPlayerWidget extends StatelessWidget {
  const BottomPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: Platform.isIOS == false,
      child: Container(
        height: 70.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.secondary,
              AppColors.secondary.withValues(alpha: 0.8),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 16.r,
              offset: Offset(0, -4.h),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              // Play Button
              Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8.r,
                      offset: Offset(0, 2.h),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: AppColors.secondary,
                  size: 32.sp,
                ),
              ),

              SizedBox(width: 16.w),

              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'آية عشوائية',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: 'Amiri',
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Play Random Ayah',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),

              // Shuffle Button
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.shuffle_rounded,
                  color: Colors.black87,
                  size: 24.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
