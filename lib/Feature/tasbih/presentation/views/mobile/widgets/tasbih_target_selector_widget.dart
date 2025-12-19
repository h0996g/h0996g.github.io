import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../Core/theme/app_colors.dart';

class TasbihTargetSelectorWidget extends StatelessWidget {
  final int selectedTarget;
  final ValueChanged<int> onTargetChanged;

  const TasbihTargetSelectorWidget({
    super.key,
    required this.selectedTarget,
    required this.onTargetChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTargetOption(10),
          _buildTargetOption(33),
          _buildTargetOption(100),
        ],
      ),
    );
  }

  Widget _buildTargetOption(int value) {
    bool isSelected = selectedTarget == value;
    return GestureDetector(
      onTap: () => onTargetChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Text(
          '$value',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
