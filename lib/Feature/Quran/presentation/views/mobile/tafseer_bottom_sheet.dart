import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Feature/Quran/data/repo/quran_repo.dart';
import 'package:noor/Feature/Quran/presentation/manager/tafseer_cubit/tafseer_cubit.dart';
import 'package:noor/Feature/Quran/presentation/views/mobile/widget/tafseer_content_widget.dart';

class TafseerBottomSheet {
  static void show(BuildContext context, int surahNumber, int ayahNumber) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return BlocProvider(
          create: (context) => TafseerCubit(QuranRepository())
            ..fetchTafseer(surahNumber: surahNumber, ayahNumber: ayahNumber),
          child: const TafseerContentWidget(),
        );
      },
    );
  }
}
