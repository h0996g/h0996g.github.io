import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/theme/app_colors.dart';

class ColorPickerWidget extends StatelessWidget {
  final Color currentColor;
  final Function(Color) onColorSelected;

  const ColorPickerWidget({
    super.key,
    required this.currentColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.black,
      Colors.white,
      Colors.grey[800]!,
      Colors.grey[200]!,
      AppColors.primary,
      AppColors.secondary,
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: colors.map((color) {
        final isSelected = color.value == currentColor.value;
        return GestureDetector(
          onTap: () => onColorSelected(color),
          child: Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.grey[300]!,
                width: isSelected ? 3 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: isSelected
                ? Icon(
                    Icons.check,
                    color: color == Colors.white || color == Colors.grey[200]
                        ? Colors.black
                        : Colors.white,
                    size: 18,
                  )
                : null,
          ),
        );
      }).toList(),
    );
  }
}
