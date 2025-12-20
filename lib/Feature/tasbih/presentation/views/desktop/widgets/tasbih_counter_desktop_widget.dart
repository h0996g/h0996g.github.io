import 'package:flutter/material.dart';
import '../../../../../../../Core/theme/app_colors.dart';

class TasbihCounterWidget extends StatefulWidget {
  final int count;
  final int target;
  final VoidCallback onIncrement;

  const TasbihCounterWidget({
    super.key,
    required this.count,
    required this.target,
    required this.onIncrement,
  });

  @override
  State<TasbihCounterWidget> createState() => _TasbihCounterWidgetState();
}

class _TasbihCounterWidgetState extends State<TasbihCounterWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((_) => _controller.reverse());
    widget.onIncrement();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 1. Safe size calculation
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;

        // Handle infinite height (if inside a ScrollView)
        if (height == double.infinity) {
          height = 400; // Fallback height
        }

        // 2. Determine the smallest dimension to keep it circular
        double size = width < height ? width : height;

        // 3. Cap the max size for large screens (optional, keeps it neat)
        if (size > 450) size = 450;

        // 4. Cap the min size so it doesn't vanish
        if (size < 200) size = 200;

        return Center(
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _handleTap,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary, AppColors.third],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(
                          _isHovered ? 0.4 : 0.3,
                        ),
                        blurRadius: _isHovered ? 30 : 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Responsive Progress Indicator
                      SizedBox(
                        width: size * 0.92,
                        height: size * 0.92,
                        child: CircularProgressIndicator(
                          value: widget.target > 0
                              ? widget.count / widget.target
                              : 0,
                          strokeWidth: size * 0.035,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white.withOpacity(0.5),
                          ),
                          backgroundColor: Colors.white.withOpacity(0.1),
                        ),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.count}',
                            style: TextStyle(
                              fontSize: size * 0.25, // Responsive Font
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.0,
                            ),
                          ),
                          Text(
                            '/ ${widget.target}',
                            style: TextStyle(
                              fontSize: size * 0.1, // Responsive Font
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),

                      // Hover hint
                      if (_isHovered)
                        Positioned(
                          bottom: size * 0.15,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size * 0.05,
                              vertical: size * 0.02,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'انقر للتسبيح',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size * 0.045,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
