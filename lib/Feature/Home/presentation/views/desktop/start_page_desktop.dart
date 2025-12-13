import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/const/app_images.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Feature/Adkar/data/repo/adkar_repo.dart';
import 'package:noor/Feature/Adkar/presentation/manager/adkar_cubit.dart';
import 'package:noor/Feature/Quran/data/repo/quran_repo.dart';
import 'package:noor/Feature/Quran/presentation/manager/quran_cubit.dart';
import '../../../../Adkar/presentation/views/adkar_sections_page.dart';
import '../../../../Feedback/presentation/views/widgets/feedback_bottom_sheet.dart';
import '../../../../NamesOfAllah/presentation/views/names_of_allah_page.dart';
import '../../../../Quran/presentation/views/surah_list_page.dart';
import '../../../../tasbih/presentation/views/tasbih_page.dart';
import 'widgets/bottom_player_desktop.dart';
import 'widgets/feature_card_desktop.dart';
import 'widgets/feedback_card_desktop.dart';
import 'widgets/home_app_bar_desktop.dart';

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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    QuranCubit(QuranRepository())
                                      ..loadQuranData(),
                                child: const SurahListPage(),
                              ),
                            ),
                          );
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    AdkarCubit(AdkarRepository())
                                      ..loadSections(),
                                child: const AdkarSectionsPage(),
                              ),
                            ),
                          );
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NamesOfAllahPage(),
                            ),
                          );
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TasbihPage(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: FeedbackCardDesktop(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const FeedbackBottomSheet(),
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
