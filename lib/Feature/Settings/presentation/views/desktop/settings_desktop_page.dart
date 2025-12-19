import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Core/widgets/appbar/desktop/custom_app_bar_desktop.dart';
import '../../manager/settings_cubit.dart';

class SettingsDesktopPage extends StatelessWidget {
  const SettingsDesktopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBarDesktop(title: 'الإعدادات'),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 700),
          padding: const EdgeInsets.all(60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Page Title
              const Text(
                'مظهر التطبيق',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontFamily: 'Amiri',
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              Text(
                'قم بتخصيص حجم النص حسب راحتك',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 60),

              // Text Size Control Card
              Container(
                padding: const EdgeInsets.all(40),
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
                child: Column(
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
                          child: const Icon(
                            Icons.text_fields_rounded,
                            color: AppColors.primary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'حجم النص',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Amiri',
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Slider Control
                    BlocBuilder<SettingsCubit, SettingsState>(
                      builder: (context, state) {
                        return Column(
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
                                trackHeight: 6.0,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 12.0,
                                ),
                                overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 24.0,
                                ),
                              ),
                              child: Slider(
                                value: state.textScaleFactor,
                                min: 0.8,
                                max: 1.5,
                                divisions: 7,
                                label: state.textScaleFactor.toStringAsFixed(1),
                                onChanged: (value) {
                                  context.read<SettingsCubit>().updateTextScale(
                                    value,
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Labels
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'صغير',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Amiri',
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'افتراضي',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Amiri',
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'كبير',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Amiri',
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 32),

                            // Divider
                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.grey[300]!,
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Preview Box
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.visibility_rounded,
                                        size: 20,
                                        color: Colors.grey[600],
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'معاينة',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
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
            ],
          ),
        ),
      ),
    );
  }
}
