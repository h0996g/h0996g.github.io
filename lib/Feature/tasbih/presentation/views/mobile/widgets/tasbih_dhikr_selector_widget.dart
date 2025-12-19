import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../Core/theme/app_colors.dart';

class TasbihDhikrSelectorWidget extends StatelessWidget {
  final List<String> dhikrOptions;
  final int selectedIndex;
  final ValueChanged<int> onDhikrChanged;

  const TasbihDhikrSelectorWidget({
    super.key,
    required this.dhikrOptions,
    required this.selectedIndex,
    required this.onDhikrChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        scrollDirection: Axis.horizontal,
        itemCount: dhikrOptions.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              onDhikrChanged(index);
              HapticFeedback.lightImpact();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey[300]!,
                  width: 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                dhikrOptions[index].replaceAll(
                  '\n',
                  ' ',
                ), // Show single line in selector
                style: TextStyle(
                  fontFamily: 'Amiri',
                  color: isSelected ? AppColors.primary : Colors.grey[600],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14.sp,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
