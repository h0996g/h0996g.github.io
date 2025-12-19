import 'package:flutter/material.dart';
import '../../../../Core/widgets/responsive_widget.dart';
import 'mobile/names_of_allah_page.dart' as mobile;
import 'desktop/names_of_allah_desktop_page.dart' as desktop;

class NamesOfAllahPage extends StatelessWidget {
  const NamesOfAllahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobile: mobile.NamesOfAllahPage(),
      desktop: desktop.NamesOfAllahDesktopPage(),
      tablet: desktop.NamesOfAllahDesktopPage(),
    );
  }
}
