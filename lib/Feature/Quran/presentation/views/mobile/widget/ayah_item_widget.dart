import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Ajr/Core/theme/app_colors.dart';
import 'package:Ajr/Feature/Quran/data/models/surah_model.dart';
import 'package:Ajr/Feature/Quran/data/models/ayah_model.dart';
import 'package:Ajr/Feature/Quran/presentation/manager/audio_cubit/audio_cubit.dart';
import 'package:Ajr/Feature/Quran/presentation/manager/audio_cubit/audio_state.dart';
import 'package:Ajr/Feature/Quran/presentation/views/mobile/tafseer_bottom_sheet.dart';

class AyahItemWidget extends StatelessWidget {
  final SurahModel surah;
  final AyahModel ayah;

  const AyahItemWidget({super.key, required this.surah, required this.ayah});

  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  BlocBuilder<AudioCubit, AudioState>(
                    builder: (context, state) {
                      bool isPlaying = false;
                      bool isLoading = false;

                      if (state.currentAyahId == ayah.number) {
                        if (state.status == AudioStatus.playing) {
                          isPlaying = true;
                        } else if (state.status == AudioStatus.loading) {
                          isLoading = true;
                        }
                      }

                      if (isLoading) {
                        return Padding(
                          padding: EdgeInsets.all(8.w),
                          child: SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }

                      return IconButton(
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          color: AppColors.primary,
                        ),
                        onPressed: () {
                          context.read<AudioCubit>().playAudio(
                            ayah.audioUrl,
                            ayah.number,
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.menu_book_rounded,
                      color: AppColors.secondary,
                    ),
                    onPressed: () {
                      TafseerBottomSheet.show(
                        context,
                        surah.number,
                        ayah.numberInSurah,
                      );
                    },
                  ),
                ],
              ),
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
