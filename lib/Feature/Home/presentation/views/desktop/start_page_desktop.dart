import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../Core/routing/app_router.dart';
import 'package:noor/Core/const/app_images.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'widgets/bottom_player_desktop.dart';
import 'widgets/feature_card_desktop.dart';
import 'widgets/feedback_card_desktop.dart';
import 'package:noor/Feature/Feedback/presentation/views/desktop/widgets/feedback_dialog_desktop.dart';
import '../../../../../Core/widgets/appbar/desktop/home_app_bar_desktop.dart';

class StartPageDesktop extends StatelessWidget {
  const StartPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const HomeAppBarDesktop(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10.h),
                // Row 1: Quran, Adkar, Names of Allah
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FeatureCardDesktop(
                        title: 'القرآن الكريم',
                        imagePath: AppImages.quran,
                        color: AppColors.primary,
                        onTap: () {
                          context.push(AppRouter.kQuran);
                        },
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: FeatureCardDesktop(
                        title: 'الأذكار',
                        imagePath: AppImages.openHands,
                        color: AppColors.third,
                        onTap: () {
                          context.push(AppRouter.kAdkar);
                        },
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: FeatureCardDesktop(
                        title: 'أسماء الله الحسنى',
                        imagePath: AppImages.namesOfAllah,
                        color: AppColors.secondary,
                        onTap: () {
                          context.push(AppRouter.kNamesOfAllah);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Row 2: Tasbih, Feedback
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FeatureCardDesktop(
                        title: 'التسبيح',
                        icon: Icons.touch_app_rounded,
                        color: AppColors.primary,
                        onTap: () {
                          context.push(AppRouter.kTasbih);
                        },
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: FeedbackCardDesktop(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => const FeedbackDialogDesktop(),
                          );
                        },
                      ),
                    ),
                    // Empty space for the 3rd column to maintain grid alignment
                    SizedBox(width: 16.w),
                    const Expanded(child: SizedBox()),
                  ],
                ),

                SizedBox(height: 32.h),

                // Bottom Player
                // BottomPlayerWidget has margin, so we just place it.
                const BottomPlayerDesktop(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
