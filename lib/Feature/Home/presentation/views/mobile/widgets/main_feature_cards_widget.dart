import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../../Core/routing/app_router.dart';
import '../../../../../../../Core/theme/app_colors.dart';
import '../../../../../../../Core/const/app_images.dart';
import 'feature_card_widget.dart';

class MainFeatureCards extends StatelessWidget {
  const MainFeatureCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          // Quran Card
          Expanded(
            child: FeatureCard(
              title: 'القرآن الكريم',

              imagePath: AppImages.quran,
              color: AppColors.primary,
              onTap: () {
                context.push(AppRouter.kQuran);
              },
            ),
          ),
          SizedBox(width: 16.w),

          // Adkar Card
          Expanded(
            child: FeatureCard(
              title: 'الأذكار',

              imagePath: AppImages.openHands,
              color: AppColors.third,
              onTap: () {
                context.push(AppRouter.kAdkar);
              },
            ),
          ),
        ],
      ),
    );
  }
}
