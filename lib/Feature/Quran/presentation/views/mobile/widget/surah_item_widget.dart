import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../Core/routing/app_router.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Feature/Quran/data/models/surah_model.dart';

class SurahItemWidget extends StatelessWidget {
  final SurahModel surah;

  const SurahItemWidget({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        leading: Container(
          width: 36.w,
          height: 36.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.secondary, width: 2),
          ),
          child: Text(
            '${surah.number}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              fontSize: 14.sp,
            ),
          ),
        ),
        title: Text(
          surah.name,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${surah.revelationType} • ${surah.ayahs.length} Ayahs',
          style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.sp,
          color: AppColors.third,
        ),
        onTap: () {
          context.push(AppRouter.kQuranDetails, extra: surah);
        },
      ),
    );
  }
}
