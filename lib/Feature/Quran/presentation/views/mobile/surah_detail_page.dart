import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Ajr/Core/widgets/appbar/mobile/custom_app_bar.dart';
import 'package:Ajr/Feature/Quran/data/models/ayah_model.dart';
import 'package:Ajr/Feature/Quran/data/models/surah_model.dart';
import 'package:Ajr/Feature/Quran/presentation/views/mobile/widget/ayah_item_widget.dart';

class SurahDetailPage extends StatelessWidget {
  final SurahModel surah;

  const SurahDetailPage({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: surah.name),
      body: Container(
        padding: EdgeInsets.all(16.w),
        child: ListView.builder(
          itemCount: surah.ayahs.length,
          itemBuilder: (context, index) {
            final AyahModel ayah = surah.ayahs[index];
            return AyahItemWidget(surah: surah, ayah: ayah);
          },
        ),
      ),
    );
  }
}
