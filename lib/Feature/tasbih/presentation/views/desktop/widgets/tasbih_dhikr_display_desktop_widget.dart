import 'package:flutter/material.dart';
import '../../../../../../../Core/theme/app_colors.dart';

class TasbihDhikrDisplayDesktopWidget extends StatelessWidget {
  final String currentDhikr;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const TasbihDhikrDisplayDesktopWidget({
    super.key,
    required this.currentDhikr,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onPrevious,
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.primary.withValues(alpha: 0.5),
              size: 28,
            ),
            tooltip: 'السابق',
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Text(
                currentDhikr,
                key: ValueKey<String>(currentDhikr),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  height: 1.8,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: onNext,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.primary.withValues(alpha: 0.5),
              size: 28,
            ),
            tooltip: 'التالي',
          ),
        ],
      ),
    );
  }
}
