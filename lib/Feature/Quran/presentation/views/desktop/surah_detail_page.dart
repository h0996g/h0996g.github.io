import 'package:flutter/material.dart';
import 'package:noor/Core/widgets/custom_app_bar.dart';
import 'package:noor/Feature/Quran/data/models/ayah_model.dart';
import 'package:noor/Feature/Quran/data/models/surah_model.dart';
import 'package:noor/Feature/Quran/presentation/views/desktop/widget/ayah_item_widget.dart';

class SurahDetailPage extends StatelessWidget {
  final SurahModel surah;

  const SurahDetailPage({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: surah.name),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
