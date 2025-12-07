import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/home_app_bar_widget.dart';
import 'widgets/main_feature_cards_widget.dart';
import 'widgets/names_of_allah_card_widget.dart';
import 'widgets/feedback_card_widget.dart';
import 'widgets/bottom_player_widget.dart';
import 'widgets/tasbih_card_widget.dart';
import '../../../tasbih/presentation/views/tasbih_page.dart';
import '../../../NamesOfAllah/presentation/views/names_of_allah_page.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NamesOfAllahPage(),
                  ),
                );
              },
            ),

            SizedBox(height: 16.h),

            // Tasbih Section
            TasbihCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TasbihPage()),
                );
              },
            ),
            SizedBox(height: 16.h),

            // Feedback Section
            FeedbackCard(
              onTap: () {
                // Navigate to Feedback
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
