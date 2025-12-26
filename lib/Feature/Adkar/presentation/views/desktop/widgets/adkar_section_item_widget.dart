import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../Core/routing/app_router.dart';
import 'package:noor/Core/const/app_images.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Feature/Adkar/data/models/adkar_section_model.dart';

class AdkarSectionItemWidget extends StatefulWidget {
  final AdkarSectionModel section;
  final int index;

  const AdkarSectionItemWidget({
    super.key,
    required this.section,
    required this.index,
  });

  @override
  State<AdkarSectionItemWidget> createState() => _AdkarSectionItemWidgetState();
}

class _AdkarSectionItemWidgetState extends State<AdkarSectionItemWidget> {
  bool _isHovered = false;

  // Map section index to appropriate image
  String _getImageForSection(int index) {
    final images = [
      AdkarImages.sunrise,
      AdkarImages.nature,
      AdkarImages.alarmClock,
      AdkarImages.sleeping,
    ];
    return images[index % images.length];
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          context.push(
            AppRouter.kAdkarDetails,
            extra: {
              'sectionId': widget.section.id,
              'sectionName': widget.section.name,
            },
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),

            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.4)
                  : Colors.grey.withValues(alpha: 0.1),
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              // Gradient overlay for depth

              // Content
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Row(
                  children: [
                    // Image Thumbnail (circular)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _isHovered
                              ? AppColors.primary
                              : AppColors.primary.withValues(alpha: 0.2),
                          width: 3,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Image
                            Image.asset(
                              _getImageForSection(widget.index),
                              fit: BoxFit.cover,
                            ),
                            // Gradient overlay
                            Container(
                              decoration: BoxDecoration(
                                gradient: _isHovered
                                    ? LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          AppColors.primary.withValues(
                                            alpha: 0.1,
                                          ),
                                          AppColors.third.withValues(
                                            alpha: 0.3,
                                          ),
                                        ],
                                      )
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 24),

                    // Text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.section.name,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: _isHovered
                                  ? AppColors.primary
                                  : AppColors.third,
                              letterSpacing: 0.5,
                              shadows: [
                                Shadow(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  offset: const Offset(0, 1),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'اضغط للاستعراض',
                            style: TextStyle(
                              fontSize: 14,
                              color: _isHovered
                                  ? AppColors.primary.withValues(alpha: 0.8)
                                  : Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Arrow (RTL - arrow_back points right in RTL)
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 200),
                      turns: _isHovered ? 0 : 0.5,
                      child: Icon(
                        Icons.arrow_back,
                        color: _isHovered
                            ? AppColors.primary
                            : Colors.grey[400],
                        size: 26,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
