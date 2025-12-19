import 'package:flutter/material.dart';
import 'package:noor/Feature/Quran/data/models/surah_model.dart';
import '../../../../Core/widgets/responsive_widget.dart';
import 'mobile/surah_detail_page.dart' as mobile;
import 'desktop/surah_detail_page.dart' as desktop;

class SurahDetailPage extends StatelessWidget {
  final SurahModel surah;

  const SurahDetailPage({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: mobile.SurahDetailPage(surah: surah),
      desktop: desktop.SurahDetailPage(surah: surah),
      tablet: desktop.SurahDetailPage(surah: surah),
    );
  }
}
