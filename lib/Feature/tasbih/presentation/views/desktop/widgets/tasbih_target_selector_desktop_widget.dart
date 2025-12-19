import 'package:flutter/material.dart';
import '../../../../../../../Core/theme/app_colors.dart';

class TasbihTargetSelectorDesktopWidget extends StatelessWidget {
  final int selectedTarget;
  final ValueChanged<int> onTargetChanged;

  const TasbihTargetSelectorDesktopWidget({
    super.key,
    required this.selectedTarget,
    required this.onTargetChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTargetOption(10),
          _buildTargetOption(33),
          _buildTargetOption(100),
        ],
      ),
    );
  }

  Widget _buildTargetOption(int value) {
    bool isSelected = selectedTarget == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTargetChanged(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            '$value',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
