import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Ajr/Core/theme/app_colors.dart';
import 'package:Ajr/Feature/Adkar/data/models/adkar_detail_model.dart';

class AdkarItemWidget extends StatefulWidget {
  final AdkarDetailModel detail;
  final VoidCallback onCompleted;

  const AdkarItemWidget({
    super.key,
    required this.detail,
    required this.onCompleted,
  });

  @override
  State<AdkarItemWidget> createState() => _AdkarItemWidgetState();
}

class _AdkarItemWidgetState extends State<AdkarItemWidget> {
  late int count;

  @override
  void initState() {
    super.initState();
    count = widget.detail.count;
  }

  void _decrementCount() {
    if (count > 0) {
      setState(() {
        count--;
      });
      if (count == 0) {
        widget.onCompleted();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: _decrementCount,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.detail.content,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18.sp,
                height: 1.8,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              alignment: Alignment.center,
              child: Text(
                'التكرار: $count',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
