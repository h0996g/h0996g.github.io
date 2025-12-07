import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Feature/Home/presentation/manager/bottom_player_cubit.dart';
import 'package:noor/Feature/Home/presentation/manager/bottom_player_state.dart';
import '../../../../../../Core/theme/app_colors.dart';

class BottomPlayerWidget extends StatelessWidget {
  const BottomPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomPlayerCubit, BottomPlayerState>(
      builder: (context, state) {
        return SafeArea(
          top: false,
          bottom: Platform.isIOS == false,
          child: Container(
            height: 145.h,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Info Row
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.music_note,
                          color: AppColors.secondary,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'آية عشوائية ${state.audioData?.id != null ? "#${state.audioData!.id}" : ""}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontFamily: 'Amiri',
                              ),
                            ),
                            Text(
                              _formatDuration(state.position) +
                                  " / " +
                                  _formatDuration(state.duration),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8.h),

                // Controls Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () =>
                          context.read<BottomPlayerCubit>().playRandomAyah(),
                      icon: Icon(
                        Icons.shuffle,
                        color: Colors.black87,
                        size: 20.sp,
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          context.read<BottomPlayerCubit>().playPrevious(),
                      icon: Icon(
                        Icons.skip_previous_rounded,
                        color: Colors.black87,
                        size: 32.sp,
                      ),
                    ),

                    // Play/Pause
                    GestureDetector(
                      onTap: () {
                        if (state.audioData != null &&
                            state.audioData!.id != null) {
                          context.read<BottomPlayerCubit>().playQuranAudio(
                            state.audioData!.id!,
                          );
                        } else {
                          context.read<BottomPlayerCubit>().playRandomAyah();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: _buildPlayIcon(state.status),
                      ),
                    ),

                    IconButton(
                      onPressed: () =>
                          context.read<BottomPlayerCubit>().playNext(),
                      icon: Icon(
                        Icons.skip_next_rounded,
                        color: Colors.black87,
                        size: 32.sp,
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          context.read<BottomPlayerCubit>().replay(),
                      icon: Icon(
                        Icons.replay,
                        color: Colors.black87,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),

                // Progress Indicator
                if (state.duration.inSeconds > 0)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 6.0,
                        ),
                        overlayShape: RoundSliderOverlayShape(
                          overlayRadius: 14.0,
                        ),
                        trackHeight: 2.0,
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.black12,
                        thumbColor: Colors.white,
                      ),
                      child: Slider(
                        value: state.position.inSeconds.toDouble().clamp(
                          0,
                          state.duration.inSeconds.toDouble(),
                        ),
                        max: state.duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          context.read<BottomPlayerCubit>().seek(
                            Duration(seconds: value.toInt()),
                          );
                        },
                      ),
                    ),
                  )
                else
                  SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlayIcon(BottomPlayerStatus status) {
    if (status == BottomPlayerStatus.loading) {
      return SizedBox(
        width: 24.w,
        height: 24.h,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.secondary,
        ),
      );
    } else if (status == BottomPlayerStatus.playing) {
      return Icon(Icons.pause, color: AppColors.secondary, size: 30.sp);
    } else {
      return Icon(Icons.play_arrow, color: AppColors.secondary, size: 30.sp);
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
