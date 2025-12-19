import 'package:flutter/material.dart';
import '../../../../../../../Core/theme/app_colors.dart';

class TasbihDhikrSelectorDesktopWidget extends StatefulWidget {
  final List<String> dhikrOptions;
  final int selectedIndex;
  final ValueChanged<int> onDhikrChanged;

  const TasbihDhikrSelectorDesktopWidget({
    super.key,
    required this.dhikrOptions,
    required this.selectedIndex,
    required this.onDhikrChanged,
  });

  @override
  State<TasbihDhikrSelectorDesktopWidget> createState() =>
      _TasbihDhikrSelectorDesktopWidgetState();
}

class _TasbihDhikrSelectorDesktopWidgetState
    extends State<TasbihDhikrSelectorDesktopWidget> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 700),
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.dhikrOptions.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          bool isSelected = widget.selectedIndex == index;
          bool isHovered = _hoveredIndex == index;
          return MouseRegion(
            onEnter: (_) => setState(() => _hoveredIndex = index),
            onExit: (_) => setState(() => _hoveredIndex = null),
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => widget.onDhikrChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : isHovered
                      ? Colors.grey[100]
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : isHovered
                        ? AppColors.primary.withValues(alpha: 0.3)
                        : Colors.grey[300]!,
                    width: isSelected ? 2 : 1.5,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.dhikrOptions[index].replaceAll('\n', ' '),
                  style: TextStyle(
                    fontFamily: 'Amiri',
                    color: isSelected ? AppColors.primary : Colors.grey[700],
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
