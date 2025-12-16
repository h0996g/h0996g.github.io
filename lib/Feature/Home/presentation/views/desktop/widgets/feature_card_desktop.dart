import 'package:flutter/material.dart';

class FeatureCardDesktop extends StatefulWidget {
  final String title;
  final String? imagePath;
  final IconData? icon;
  final Color color;
  final VoidCallback onTap;

  const FeatureCardDesktop({
    super.key,
    required this.title,
    this.imagePath,
    this.icon,
    required this.color,
    required this.onTap,
  }) : assert(
         imagePath != null || icon != null,
         'Either imagePath or icon must be provided',
       );

  @override
  State<FeatureCardDesktop> createState() => _FeatureCardDesktopState();
}

class _FeatureCardDesktopState extends State<FeatureCardDesktop> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [widget.color, widget.color.withValues(alpha: 0.8)],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.3),
                blurRadius: _isHovered ? 20 : 10,
                offset: _isHovered ? const Offset(0, 10) : const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Decorative Background (Large & Faded)
              Positioned(
                right: -20,
                bottom: -20,
                child: widget.imagePath != null
                    ? Image.asset(
                        widget.imagePath!,
                        width: 140,
                        height: 140,
                        color: Colors.white.withValues(alpha: 0.1),
                      )
                    : Icon(
                        widget.icon,
                        size: 140,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Icon/Image Container
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: widget.imagePath != null
                          ? Image.asset(
                              widget.imagePath!,
                              width: 32,
                              height: 32,
                              color: Colors.white,
                            )
                          : Icon(widget.icon, size: 32, color: Colors.white),
                    ),

                    const SizedBox(height: 16),

                    // Title
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Amiri',
                      ),
                    ),

                    // Arrow Icon
                    const Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white70,
                        size: 24,
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
