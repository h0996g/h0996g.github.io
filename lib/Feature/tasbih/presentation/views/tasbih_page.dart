import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Core/theme/app_colors.dart';
import '../manager/tasbih_cubit.dart';
import '../manager/tasbih_state.dart';

import 'widgets/tasbih_target_selector_widget.dart';
import 'widgets/tasbih_dhikr_selector_widget.dart';
import 'widgets/tasbih_dhikr_display_widget.dart';
import 'widgets/tasbih_counter_widget.dart';

class TasbihPage extends StatelessWidget {
  const TasbihPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasbihCubit(),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text(
            'التسبيح',
            style: TextStyle(
              fontFamily: 'Amiri',
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<TasbihCubit, TasbihState>(
            builder: (context, state) {
              final cubit = context.read<TasbihCubit>();
              return Column(
                children: [
                  SizedBox(height: 20.h),
                  TasbihTargetSelectorWidget(
                    selectedTarget: state.target,
                    onTargetChanged: cubit.setTarget,
                  ),
                  SizedBox(height: 20.h),
                  TasbihDhikrSelectorWidget(
                    dhikrOptions: TasbihState.dhikrOptions,
                    selectedIndex: state.selectedDhikrIndex,
                    onDhikrChanged: cubit.changeDhikrIndex,
                  ),
                  Spacer(),
                  TasbihDhikrDisplayWidget(
                    currentDhikr: state.currentDhikr,
                    onNext: () => cubit.cycleDhikr(1),
                    onPrevious: () => cubit.cycleDhikr(-1),
                  ),
                  Spacer(),
                  TasbihCounterWidget(
                    count: state.count,
                    target: state.target,
                    onIncrement: cubit.increment,
                  ),
                  SizedBox(height: 30.h),
                  TextButton.icon(
                    onPressed: cubit.reset,
                    icon: Icon(Icons.refresh, color: AppColors.primary),
                    label: Text(
                      'Reset',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16.sp,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
