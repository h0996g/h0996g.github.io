import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Feature/Quran/presentation/views/mobile/widget/surah_item_widget.dart';
import '../../../../../Core/theme/app_colors.dart';
import '../../manager/quran_cubit/quran_cubit.dart';
import '../../manager/quran_cubit/quran_state.dart';
import 'package:noor/Core/widgets/appbar/mobile/custom_app_bar.dart';

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
            return ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: state.surahs.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final surah = state.surahs[index];
                return SurahItemWidget(surah: surah);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
