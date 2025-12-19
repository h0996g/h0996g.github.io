import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      backgroundColor: Colors.grey[50],
      body: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state.status == QuranStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state.status == QuranStatus.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 64,
                    color: Colors.red[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'حدث خطأ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.errorMessage ?? 'خطأ غير معروف',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          } else if (state.status == QuranStatus.success) {
            return LayoutBuilder(
              builder: (context, constraints) {
                // Calculate number of columns based on available width
                // Target card width roughly 280px for better spacing
                final int crossAxisCount = (constraints.maxWidth / 280)
                    .floor()
                    .clamp(2, 5);

                return GridView.builder(
                  padding: const EdgeInsets.all(32),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 1.15,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
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
