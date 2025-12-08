import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../Core/theme/app_colors.dart';
import '../../../../../../Core/const/app_images.dart';

class NamesOfAllahCard extends StatelessWidget {
  final VoidCallback onTap;

  const NamesOfAllahCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.secondary,
                AppColors.secondary.withValues(alpha: 0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 12.r,
                offset: Offset(0, 6.h),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Decorative Pattern
              Positioned(
                right: -30.w,
                top: -30.h,
                child: Image.asset(
                  AppImages.namesOfAllah,
                  height: 150.sp,
                  width: 150.sp,
                  // color: Colors.white.withValues(alpha: 0.9),
                ),
              ),

              // Content
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Image.asset(
                        AppImages.namesOfAllah,
                        // color: Colors.white,
                        height: 40.sp,
                        width: 40.sp,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'أسماء الله الحسنى',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Amiri',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
