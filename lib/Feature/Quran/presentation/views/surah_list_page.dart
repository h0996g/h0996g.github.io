import 'package:flutter/material.dart';
import '../../../../Core/widgets/responsive_widget.dart';
import 'mobile/surah_list_page.dart' as mobile;
import 'desktop/surah_list_page.dart' as desktop;

class SurahListPage extends StatelessWidget {
  const SurahListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobile: mobile.SurahListPage(),
      desktop: desktop.SurahListPage(),
      tablet: desktop.SurahListPage(),
    );
  }
}
