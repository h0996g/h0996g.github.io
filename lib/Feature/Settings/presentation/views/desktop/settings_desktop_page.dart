import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Ajr/Core/theme/app_colors.dart';
import 'package:Ajr/Core/widgets/appbar/desktop/custom_app_bar_desktop.dart';
import '../../manager/settings_cubit.dart';

class SettingsDesktopPage extends StatelessWidget {
  const SettingsDesktopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBarDesktop(title: 'الإعدادات'),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double screenHeight = constraints.maxHeight;
          final bool isCompact = screenHeight < 750;
          final double horizontalPadding = constraints.maxWidth > 900 ? 40 : 20;

          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isCompact ? 16 : 32,
              ),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 750),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(isCompact ? 24 : 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.text_fields_rounded,
                              color: AppColors.primary,
                              size: isCompact ? 24 : 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'حجم النص',
                            style: TextStyle(
                              fontSize: isCompact ? 20 : 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Amiri',
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: isCompact ? 20 : 40),

                      // Slider Control
                      BlocBuilder<SettingsCubit, SettingsState>(
                        builder: (context, state) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Slider
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: AppColors.primary,
                                  inactiveTrackColor: AppColors.primary
                                      .withValues(alpha: 0.2),
                                  thumbColor: AppColors.primary,
                                  overlayColor: AppColors.primary.withValues(
                                    alpha: 0.2,
                                  ),
                                  trackHeight: isCompact ? 4.0 : 6.0,
                                  thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: isCompact ? 10.0 : 12.0,
                                  ),
                                  overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: isCompact ? 20.0 : 24.0,
                                  ),
                                ),
                                child: Slider(
                                  value: state.textScaleFactor,
                                  min: 0.8,
                                  max: 1.5,
                                  divisions: 7,
                                  label: state.textScaleFactor.toStringAsFixed(
                                    1,
                                  ),
                                  onChanged: (value) {
                                    context
                                        .read<SettingsCubit>()
                                        .updateTextScale(value);
                                  },
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Labels
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildLabel('صغير'),
                                  _buildLabel('افتراضي'),
                                  _buildLabel('كبير'),
                                ],
                              ),

                              SizedBox(height: isCompact ? 24 : 32),

                              // Divider
                              const _GradientDivider(),

                              SizedBox(height: isCompact ? 24 : 40),

                              // Preview Box
                              Container(
                                padding: EdgeInsets.all(isCompact ? 16 : 24),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.visibility_rounded,
                                          size: isCompact ? 18 : 20,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'معاينة',
                                          style: TextStyle(
                                            fontSize: isCompact ? 13 : 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: isCompact ? 12 : 16),
                                    Text(
                                      'هذا نص تجريبي لمعاينة حجم الخط. يمكنك ضبط الحجم باستخدام الشريط أعلاه.',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Amiri',
                                        height: 1.8,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontFamily: 'Amiri',
        color: Colors.grey[600],
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _GradientDivider extends StatelessWidget {
  const _GradientDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Colors.grey[300]!, Colors.transparent],
        ),
      ),
    );
  }
}
