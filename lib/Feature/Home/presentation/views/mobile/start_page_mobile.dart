import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../Core/routing/app_router.dart';
import '../../../../../Core/widgets/appbar/mobile/home_app_bar_widget.dart';
import 'widgets/main_feature_cards_widget.dart';
import 'widgets/names_of_allah_card_widget.dart';
import '../../../../Feedback/presentation/views/feedback_card_widget.dart';
import 'widgets/bottom_player_widget.dart';
import 'widgets/tasbih_card_widget.dart';
import '../../../../Feedback/presentation/views/widgets/feedback_bottom_sheet.dart';

class StartPageMobile extends StatelessWidget {
  const StartPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Column(
          children: [
            SizedBox(height: 20.h),

            // Main Feature Cards (Quran & Adkar)
            const MainFeatureCards(),

            SizedBox(height: 16.h),

            // Names of Allah Section
            NamesOfAllahCard(
              onTap: () {
                context.push(AppRouter.kNamesOfAllah);
              },
            ),

            SizedBox(height: 16.h),

            // Tasbih Section
            TasbihCard(
              onTap: () {
                context.push(AppRouter.kTasbih);
              },
            ),
            SizedBox(height: 16.h),

            // Feedback Section
            FeedbackCard(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  useSafeArea: true,
                  builder: (context) =>
                      SafeArea(child: const FeedbackBottomSheet()),
                );
              },
            ),

            SizedBox(height: 16.h),

            // Bottom Player for Random Ayah
            const BottomPlayerWidget(),
          ],
        ),
      ),
    );
  }
}
