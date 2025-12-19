import 'package:flutter/material.dart';
import '../../../../Core/widgets/responsive_widget.dart';
import 'mobile/tasbih_page.dart' as mobile;
import 'desktop/tasbih_desktop_page.dart' as desktop;

class TasbihPage extends StatelessWidget {
  const TasbihPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobile: mobile.TasbihPage(),
      desktop: desktop.TasbihDesktopPage(),
      tablet: desktop.TasbihDesktopPage(),
    );
  }
}
