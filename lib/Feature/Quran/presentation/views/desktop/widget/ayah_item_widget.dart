import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Feature/Quran/data/models/surah_model.dart';
import 'package:noor/Feature/Quran/data/models/ayah_model.dart';
import 'package:noor/Feature/Quran/presentation/manager/audio_cubit/audio_cubit.dart';
import 'package:noor/Feature/Quran/presentation/manager/audio_cubit/audio_state.dart';
import '../tafseer_dialog.dart';

class AyahItemWidget extends StatelessWidget {
  final SurahModel surah;
  final AyahModel ayah;

  const AyahItemWidget({super.key, required this.surah, required this.ayah});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
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
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.secondary, width: 2),
                ),
                child: Text(
                  '${ayah.numberInSurah}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
                        return const Padding(
                          padding: EdgeInsets.all(8),
                          child: SizedBox(
                            width: 28,
                            height: 28,
                            child: CircularProgressIndicator(
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
                          size: 32,
                        ),
                        onPressed: () {
                          context.read<AudioCubit>().playAudio(
                            ayah.audioUrl,
                            ayah.number,
                          );
                        },
                        tooltip: isPlaying ? 'إيقاف' : 'تشغيل',
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Tooltip(
                    message: 'التفسير',
                    child: IconButton(
                      icon: const Icon(
                        Icons.menu_book_rounded,
                        color: AppColors.secondary,
                        size: 28,
                      ),
                      onPressed: () {
                        TafseerDialog.show(
                          context,
                          surah.number,
                          ayah.numberInSurah,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            ayah.text,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 26,
              height: 2.2,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              fontFamily: 'Amiri',
            ),
          ),
        ],
      ),
    );
  }
}
