import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Feature/Home/presentation/manager/bottom_player_cubit.dart';
import 'package:noor/Feature/Home/presentation/manager/bottom_player_state.dart';

class BottomPlayerDesktop extends StatelessWidget {
  const BottomPlayerDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomPlayerCubit, BottomPlayerState>(
      builder: (context, state) {
        return Container(
          // No SafeArea needed for bottom on desktop usually, but can add if necessary.
          // Removed margin logic that used .w/.h
          // We can use standard padding/margin for desktop.
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
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
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      // Left Section: Icon and Song Info
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.multitrack_audio_rounded,
                          color: AppColors.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 20),

                      // Title
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'آية',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontFamily: 'Amiri',
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${_formatDuration(state.position)} / ${_formatDuration(state.duration)}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 32),

                      // Middle Section: Controls (Previous, Play, Next)
                      // On desktop, we might want these centered or more prominent.
                      // Let's keep them in the row flow but maybe give them more space.
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Shuffle
                          IconButton(
                            onPressed: () => context
                                .read<BottomPlayerCubit>()
                                .playRandomAyah(),
                            icon: Icon(
                              Icons.shuffle_rounded,
                              color: Colors.grey[600],
                              size: 24,
                            ),
                            splashRadius: 24,
                          ),
                          const SizedBox(width: 8),

                          // Previous
                          IconButton(
                            onPressed: () => context
                                .read<BottomPlayerCubit>()
                                .playPrevious(),
                            icon: Transform.flip(
                              flipX: true,
                              child: const Icon(
                                Icons.skip_previous_rounded,
                                color: Colors.black87,
                                size: 32,
                              ),
                            ),
                            splashRadius: 28,
                          ),
                          const SizedBox(width: 16),

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
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              height: 64,
                              width: 64,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: _buildPlayIcon(state.status),
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Next
                          IconButton(
                            onPressed: () =>
                                context.read<BottomPlayerCubit>().playNext(),
                            icon: Transform.flip(
                              flipX: true,
                              child: const Icon(
                                Icons.skip_next_rounded,
                                color: Colors.black87,
                                size: 32,
                              ),
                            ),
                            splashRadius: 28,
                          ),

                          const SizedBox(width: 8),

                          // Replay
                          IconButton(
                            onPressed: () =>
                                context.read<BottomPlayerCubit>().replay(),
                            icon: Icon(
                              Icons.replay_rounded,
                              color: Colors.grey[600],
                              size: 24,
                            ),
                            splashRadius: 24,
                          ),
                        ],
                      ),

                      const SizedBox(width: 32),

                      // Right Section: Slider (Longer on desktop)
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: 20,
                          child: state.duration.inSeconds > 0
                              ? SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: AppColors.primary,
                                    inactiveTrackColor: AppColors.primary
                                        .withValues(alpha: 0.1),
                                    thumbColor: AppColors.primary,
                                    trackShape:
                                        const RoundedRectSliderTrackShape(),
                                    trackHeight: 4.0,
                                    thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 6.0,
                                    ),
                                    overlayShape: const RoundSliderOverlayShape(
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
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 0,
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlayIcon(BottomPlayerStatus status) {
    if (status == BottomPlayerStatus.loading) {
      return const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: Colors.white,
          ),
        ),
      );
    } else if (status == BottomPlayerStatus.playing) {
      return const Icon(Icons.pause_rounded, color: Colors.white, size: 32);
    } else {
      return Transform.flip(
        flipX: true,
        child: const Icon(
          Icons.play_arrow_rounded,
          color: Colors.white,
          size: 36,
        ),
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
