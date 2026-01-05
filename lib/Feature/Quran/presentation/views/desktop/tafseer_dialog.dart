import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Ajr/Feature/Quran/data/repo/quran_repo.dart';
import 'package:Ajr/Feature/Quran/presentation/manager/tafseer_cubit/tafseer_cubit.dart';
import 'package:Ajr/Feature/Quran/presentation/views/desktop/widget/tafseer_content_widget.dart';

class TafseerDialog {
  static void show(BuildContext context, int surahNumber, int ayahNumber) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            width: 600,
            height: 700,
            child: BlocProvider(
              create: (context) => TafseerCubit(
                QuranRepository(),
              )..fetchTafseer(surahNumber: surahNumber, ayahNumber: ayahNumber),
              child: const TafseerContentWidget(),
            ),
          ),
        );
      },
    );
  }
}
