import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Core/theme/app_colors.dart';
import '../../data/models/surah_model.dart';
import '../../data/models/ayah_model.dart';

class SurahDetailPage extends StatelessWidget {
  final SurahModel surah;

  const SurahDetailPage({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          surah.name,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(16.w),
        child: ListView.builder(
          itemCount: surah.ayahs.length,
          itemBuilder: (context, index) {
            final AyahModel ayah = surah.ayahs[index];
            return _buildAyahItem(ayah);
          },
        ),
      ),
    );
  }

  Widget _buildAyahItem(AyahModel ayah) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(12.w),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 30.w,
                height: 30.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${ayah.numberInSurah}',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            ayah.text,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 20.sp,
              height: 1.8,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
