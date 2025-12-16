import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Feature/Quran/presentation/manager/tafseer_cubit/tafseer_cubit.dart';
import 'package:noor/Feature/Quran/presentation/manager/tafseer_cubit/tafseer_state.dart';

class TafseerContentWidget extends StatelessWidget {
  const TafseerContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: BlocBuilder<TafseerCubit, TafseerState>(
            builder: (context, state) {
              if (state.status == TafseerStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              if (state.status == TafseerStatus.failure) {
                return Center(child: Text('Error: ${state.errorMessage}'));
              }

              if (state.status == TafseerStatus.success &&
                  state.tafseer != null) {
                return Column(
                  children: [
                    Container(
                      width: 40.w,
                      height: 4.h,
                      margin: EdgeInsets.only(bottom: 20.h),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    Text(
                      state.tafseer!.tafseerName,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Text(
                          state.tafseer!.text,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 16.sp,
                            height: 1.6,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
