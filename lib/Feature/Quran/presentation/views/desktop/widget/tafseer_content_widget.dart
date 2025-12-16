import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Feature/Quran/presentation/manager/tafseer_cubit/tafseer_cubit.dart';
import 'package:noor/Feature/Quran/presentation/manager/tafseer_cubit/tafseer_state.dart';

class TafseerContentWidget extends StatelessWidget {
  const TafseerContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BlocBuilder<TafseerCubit, TafseerState>(
        builder: (context, state) {
          if (state.status == TafseerStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state.status == TafseerStatus.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'خطأ: ${state.errorMessage}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontFamily: 'Amiri',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state.status == TafseerStatus.success && state.tafseer != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        state.tafseer!.tafseerName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontFamily: 'Amiri',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 24),
                      onPressed: () => Navigator.of(context).pop(),
                      tooltip: 'إغلاق',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      state.tafseer!.text,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.8,
                        color: Colors.black87,
                        fontFamily: 'Amiri',
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
