import 'package:flutter/material.dart';
import 'package:Ajr/Core/theme/app_colors.dart';
import 'package:Ajr/Feature/Home/presentation/views/desktop/widgets/bottom_player_desktop.dart';

class AdkarCompletionDesktopWidget extends StatelessWidget {
  const AdkarCompletionDesktopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary.withValues(alpha: 0.15),
                      AppColors.third.withValues(alpha: 0.15),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: 80,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 32),

              // Completion Message
              const Text(
                'تم الانتهاء من الأذكار',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Amiri',
                  color: AppColors.primary,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Subtitle
              Text(
                'تقبل الله منا ومنكم صالح الأعمال',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Bottom Player - Full Width
              const BottomPlayerDesktop(),
            ],
          ),
        ),
      ),
    );
  }
}
