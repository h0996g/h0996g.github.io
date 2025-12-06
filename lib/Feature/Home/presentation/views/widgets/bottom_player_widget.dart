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
            height: 70.h,
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  // Play Button
                  GestureDetector(
                    onTap: () {
                      // Trigger play for ID 1 as requested
                      context.read<BottomPlayerCubit>().playQuranAudio(1);
                    },
                    child: Container(
                      width: 56.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8.r,
                            offset: Offset(0, 2.h),
                          ),
                        ],
                      ),
                      child: _buildPlayIcon(state.status),
                    ),
                  ),

                  SizedBox(width: 16.w),

                  // Text Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'آية عشوائية',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontFamily: 'Amiri',
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          state.status == BottomPlayerStatus.playing
                              ? 'Playing...'
                              : state.status == BottomPlayerStatus.loading
                              ? 'Loading...'
                              : 'Play Random Ayah',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black.withValues(alpha: 0.7),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Shuffle Button (Can be used to generate random ID later)
                  GestureDetector(
                    onTap: () {
                      // Future implementation for random ID
                      context.read<BottomPlayerCubit>().playQuranAudio(1);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.shuffle_rounded,
                        color: Colors.black87,
                        size: 24.sp,
                      ),
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
      return Padding(
        padding: EdgeInsets.all(14.w),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.secondary,
        ),
      );
    } else if (status == BottomPlayerStatus.playing) {
      return Icon(Icons.pause_rounded, color: AppColors.secondary, size: 32.sp);
    } else {
      return Icon(
        Icons.play_arrow_rounded,
        color: AppColors.secondary,
        size: 32.sp,
      );
    }
  }
}
