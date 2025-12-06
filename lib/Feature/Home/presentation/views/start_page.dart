import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/home_app_bar_widget.dart';
import '../widgets/main_feature_cards_widget.dart';
import '../widgets/names_of_allah_card_widget.dart';
// import '../widgets/tasbih_card_widget.dart';
import '../widgets/feedback_card_widget.dart';
import '../widgets/bottom_player_widget.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

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
                // Navigate to Names of Allah
              },
            ),

            SizedBox(height: 16.h),

            // Tasbih Section
            // TasbihCard(
            //   onTap: () {
            //     // Navigate to Tasbih
            //   },
            // ),
            SizedBox(height: 16.h),

            // Feedback Section
            FeedbackCard(
              onTap: () {
                // Navigate to Feedback
              },
            ),
          ],
        ),
      ),

      // Bottom Player for Random Ayah
      bottomNavigationBar: const BottomPlayerWidget(),
    );
  }
}
