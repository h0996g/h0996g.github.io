import 'package:flutter/foundation.dart';
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
          bottom: defaultTargetPlatform != TargetPlatform.iOS,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20.r,
                  offset: Offset(0, 8.h),
                ),
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.05),
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: Stack(
                children: [
                  // Background Gradient Effect (Subtle)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white,
                            AppColors.primary.withValues(alpha: 0.03),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Top Section: Icon, Info, Duration
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Icon(
                                Icons.multitrack_audio_rounded,
                                color: AppColors.primary,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'آية عشوائية',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                      fontFamily: 'Amiri',
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "${_formatDuration(state.position)} / ${_formatDuration(state.duration)}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10.h),

                        // Progress Slider
                        SizedBox(
                          height: 20.h,
                          child: state.duration.inSeconds > 0
                              ? SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: AppColors.primary,
                                    inactiveTrackColor: AppColors.primary
                                        .withValues(alpha: 0.1),
                                    thumbColor: AppColors.primary,
                                    trackShape: RoundedRectSliderTrackShape(),
                                    trackHeight: 4.0,
                                    thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 6.0,
                                    ),
                                    overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 14.0,
                                    ),
                                  ),
                                  child: Slider(
                                    value: state.position.inSeconds
                                        .toDouble()
                                        .clamp(
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
                                )
                              : Center(
                                  child: Container(
                                    height: 4.0,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 24.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                        ),

                        SizedBox(height: 12.h),

                        // Controls
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Shuffle
                            IconButton(
                              onPressed: () => context
                                  .read<BottomPlayerCubit>()
                                  .playRandomAyah(),
                              icon: Icon(
                                Icons.shuffle_rounded,
                                color: Colors.grey[600],
                                size: 20.sp,
                              ),
                              splashRadius: 20.r,
                            ),

                            // Previous
                            IconButton(
                              onPressed: () => context
                                  .read<BottomPlayerCubit>()
                                  .playPrevious(),
                              icon: Transform.flip(
                                flipX: true,
                                child: Icon(
                                  Icons.skip_previous_rounded,
                                  color: Colors.black87,
                                  size: 28.sp,
                                ),
                              ),
                            ),

                            // Play/Pause Main Button
                            InkWell(
                              onTap: () {
                                if (state.audioData != null &&
                                    state.audioData!.id != null) {
                                  context
                                      .read<BottomPlayerCubit>()
                                      .playQuranAudio(state.audioData!.id!);
                                } else {
                                  context
                                      .read<BottomPlayerCubit>()
                                      .playRandomAyah();
                                }
                              },
                              borderRadius: BorderRadius.circular(50.r),
                              child: Container(
                                height: 64.h,
                                width: 64.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 12,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: _buildPlayIcon(state.status),
                              ),
                            ),

                            // Next
                            IconButton(
                              onPressed: () =>
                                  context.read<BottomPlayerCubit>().playNext(),
                              icon: Transform.flip(
                                flipX: true,
                                child: Icon(
                                  Icons.skip_next_rounded,
                                  color: Colors.black87,
                                  size: 28.sp,
                                ),
                              ),
                            ),

                            // Replay
                            IconButton(
                              onPressed: () =>
                                  context.read<BottomPlayerCubit>().replay(),
                              icon: Icon(
                                Icons.replay_rounded,
                                color: Colors.grey[600],
                                size: 22.sp,
                              ),
                              splashRadius: 20.r,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlayIcon(BottomPlayerStatus status) {
    if (status == BottomPlayerStatus.loading) {
      return Center(
        child: SizedBox(
          width: 24.w,
          height: 24.h,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: Colors.white,
          ),
        ),
      );
    } else if (status == BottomPlayerStatus.playing) {
      return Icon(Icons.pause_rounded, color: Colors.white, size: 32.sp);
    } else {
      return Transform.flip(
        flipX: true,
        child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 36.sp),
      );
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
