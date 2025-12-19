import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Feature/Adkar/presentation/views/mobile/widgets/adkar_section_item_widget.dart';
import '../../manager/adkar_cubit.dart';
import '../../manager/adkar_state.dart';
import 'package:noor/Core/widgets/custom_app_bar.dart';

class AdkarSectionsPage extends StatelessWidget {
  const AdkarSectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الأذكار'),
      body: BlocBuilder<AdkarCubit, AdkarState>(
        builder: (context, state) {
          if (state.status == AdkarStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state.status == AdkarStatus.failure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else if (state.status == AdkarStatus.success) {
            return ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: state.sections.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final section = state.sections[index];
                return AdkarSectionItemWidget(section: section);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
