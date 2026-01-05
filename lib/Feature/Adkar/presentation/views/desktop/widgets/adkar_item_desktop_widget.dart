import 'package:flutter/material.dart';
import 'package:Ajr/Core/theme/app_colors.dart';
import 'package:Ajr/Feature/Adkar/data/models/adkar_detail_model.dart';

class AdkarItemDesktopWidget extends StatefulWidget {
  final AdkarDetailModel detail;
  final bool isCompleted;
  final VoidCallback onCompleted;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final int currentIndex;
  final int totalCount;

  const AdkarItemDesktopWidget({
    super.key,
    required this.detail,
    required this.isCompleted,
    required this.onCompleted,
    this.onPrevious,
    this.onNext,
    required this.currentIndex,
    required this.totalCount,
  });

  @override
  State<AdkarItemDesktopWidget> createState() => _AdkarItemDesktopWidgetState();
}

class _AdkarItemDesktopWidgetState extends State<AdkarItemDesktopWidget> {
  late int count;

  @override
  void initState() {
    super.initState();
    count = widget.detail.count;
  }

  @override
  void didUpdateWidget(AdkarItemDesktopWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.detail != oldWidget.detail) {
      count = widget.detail.count;
    }
  }

  void _decrementCount() {
    if (count > 0) {
      setState(() {
        count--;
      });
      if (count == 0) {
        widget.onCompleted();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main Card - Takes available space (content only, no button)
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.detail.content,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        height: 1.8,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Counter Button - Fixed above navigation
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          child: GestureDetector(
            onTap: count > 0 ? _decrementCount : null,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: count > 0 ? null : Colors.grey[300],
                gradient: count > 0
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primary, AppColors.third],
                      )
                    : null,
                borderRadius: BorderRadius.circular(16),
                boxShadow: count > 0
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (count > 0) ...[
                    const Icon(Icons.touch_app, color: Colors.white, size: 24),
                    const SizedBox(width: 12),
                  ],
                  Text(
                    count > 0 ? 'التكرار: $count' : 'مكتمل ✓',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: count > 0 ? Colors.white : Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Navigation Buttons - Fixed at bottom
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Previous Button
              if (widget.onPrevious != null)
                _NavigationButton(
                  icon: Icons.arrow_back,
                  label: 'السابق',
                  onTap: widget.onPrevious!,
                ),

              if (widget.onPrevious != null && widget.onNext != null)
                const SizedBox(width: 16),

              // Page Indicator
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
                child: Text(
                  '${widget.currentIndex} / ${widget.totalCount}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),

              if (widget.onPrevious != null && widget.onNext != null)
                const SizedBox(width: 16),

              // Next Button
              if (widget.onNext != null)
                _NavigationButton(
                  icon: Icons.arrow_forward,
                  label: 'التالي',
                  onTap: widget.onNext!,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavigationButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
