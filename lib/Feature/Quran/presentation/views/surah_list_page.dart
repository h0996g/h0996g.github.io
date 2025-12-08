import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Feature/Quran/presentation/manager/audio_cubit.dart';
import '../../../../Core/theme/app_colors.dart';
import '../../presentation/manager/quran_cubit.dart';
import '../../presentation/manager/quran_state.dart';
import 'surah_detail_page.dart';

import 'package:noor/Core/widgets/custom_app_bar.dart';

class SurahListPage extends StatelessWidget {
  const SurahListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'السور'),
      body: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state.status == QuranStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state.status == QuranStatus.failure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else if (state.status == QuranStatus.success) {
            return ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: state.surahs.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final surah = state.surahs[index];
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
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 4.h,
                    ),
                    leading: Container(
                      width: 36.w,
                      height: 36.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.secondary,
                          width: 2,
                        ),
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
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${surah.revelationType} • ${surah.ayahs.length} Ayahs',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.sp,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                      color: AppColors.third,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => AudioCubit(),
                            child: SurahDetailPage(surah: surah),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
