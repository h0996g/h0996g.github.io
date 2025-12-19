import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/theme/app_colors.dart';
import '../../../../../Core/widgets/custom_app_bar.dart';
import '../../manager/tasbih_cubit.dart';
import '../../manager/tasbih_state.dart';
import 'widgets/tasbih_counter_desktop_widget.dart';
import 'widgets/tasbih_dhikr_display_desktop_widget.dart';
import 'widgets/tasbih_dhikr_selector_desktop_widget.dart';
import 'widgets/tasbih_target_selector_desktop_widget.dart';

class TasbihDesktopPage extends StatelessWidget {
  const TasbihDesktopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasbihCubit(),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: const CustomAppBar(title: 'التسبيح'),
        body: BlocBuilder<TasbihCubit, TasbihState>(
          builder: (context, state) {
            final cubit = context.read<TasbihCubit>();
            return Row(
              children: [
                // Left Side - Counter (40%)
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Counter Button
                        TasbihCounterDesktopWidget(
                          count: state.count,
                          target: state.target,
                          onIncrement: cubit.increment,
                        ),

                        const SizedBox(height: 40),

                        // Reset Button
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: TextButton.icon(
                            onPressed: cubit.reset,
                            icon: const Icon(
                              Icons.refresh,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            label: const Text(
                              'إعادة تعيين',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 14,
                              ),
                              backgroundColor: AppColors.primary.withValues(
                                alpha: 0.1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Right Side - Controls (60%)
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(60),
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Title
                            const Text(
                              'اختر الذكر والهدف',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                fontFamily: 'Amiri',
                              ),
                            ),

                            const SizedBox(height: 40),

                            // Target Selector
                            Center(
                              child: TasbihTargetSelectorDesktopWidget(
                                selectedTarget: state.target,
                                onTargetChanged: cubit.setTarget,
                              ),
                            ),

                            const SizedBox(height: 40),

                            // Section Label
                            Text(
                              'الأذكار المتاحة',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Dhikr Selector
                            Center(
                              child: TasbihDhikrSelectorDesktopWidget(
                                dhikrOptions: TasbihState.dhikrOptions,
                                selectedIndex: state.selectedDhikrIndex,
                                onDhikrChanged: cubit.changeDhikrIndex,
                              ),
                            ),

                            const SizedBox(height: 50),

                            // Divider
                            Container(
                              height: 2,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 80,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    AppColors.primary.withValues(alpha: 0.3),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 50),

                            // Current Dhikr Display
                            TasbihDhikrDisplayDesktopWidget(
                              currentDhikr: state.currentDhikr,
                              onNext: () => cubit.cycleDhikr(1),
                              onPrevious: () => cubit.cycleDhikr(-1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
