import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:noor/Feature/Home/data/repo/home_repo.dart';
import 'package:noor/Feature/Home/presentation/manager/bottom_player_cubit.dart';
import 'widgets/home_app_bar_widget.dart';
import 'widgets/main_feature_cards_widget.dart';
import 'widgets/names_of_allah_card_widget.dart';
import 'widgets/feedback_card_widget.dart';
import 'widgets/bottom_player_widget.dart';
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
      bottomNavigationBar: BlocProvider(
        create: (context) =>
            BottomPlayerCubit(HomeRepository(Supabase.instance.client)),
        child: const BottomPlayerWidget(),
      ),
    );
  }
}
