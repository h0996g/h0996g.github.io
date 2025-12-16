import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Feature/Adkar/data/repo/adkar_repo.dart';
import 'package:noor/Feature/Adkar/presentation/manager/adkar_cubit.dart';
import 'package:noor/Feature/Quran/data/repo/quran_repo.dart';
import 'package:noor/Feature/Quran/presentation/manager/quran_cubit/quran_cubit.dart';
import '../../../../../../../Core/theme/app_colors.dart';
import '../../../../../../../Core/const/app_images.dart';
import 'feature_card_widget.dart';
import '../../../../../Quran/presentation/views/mobile/surah_list_page.dart';
import '../../../../../Adkar/presentation/views/adkar_sections_page.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) =>
                          QuranCubit(QuranRepository())..loadQuranData(),
                      child: const SurahListPage(),
                    ),
                  ),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) =>
                          AdkarCubit(AdkarRepository())..loadSections(),
                      child: const AdkarSectionsPage(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
