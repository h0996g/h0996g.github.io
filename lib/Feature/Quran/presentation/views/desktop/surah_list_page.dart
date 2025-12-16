import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Core/widgets/custom_app_bar.dart';
import 'package:noor/Feature/Quran/presentation/manager/quran_cubit/quran_cubit.dart';
import 'package:noor/Feature/Quran/presentation/manager/quran_cubit/quran_state.dart';
import 'package:noor/Feature/Quran/presentation/views/desktop/widget/surah_item_widget.dart';

class SurahListPage extends StatelessWidget {
  const SurahListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'السور'),
      body: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state.status == QuranStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state.status == QuranStatus.failure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else if (state.status == QuranStatus.success) {
            return LayoutBuilder(
              builder: (context, constraints) {
                // Calculate number of columns based on available width
                // Target card width roughly 250px
                final int crossAxisCount = (constraints.maxWidth / 250)
                    .floor()
                    .clamp(2, 6);

                return GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 24.h,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: state.surahs.length,
                  itemBuilder: (context, index) {
                    final surah = state.surahs[index];
                    return SurahItemWidget(surah: surah);
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
