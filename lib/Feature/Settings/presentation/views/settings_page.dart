import 'package:flutter/material.dart';
import '../../../../Core/widgets/responsive_widget.dart';
import 'mobile/settings_page.dart' as mobile;
import 'desktop/settings_desktop_page.dart' as desktop;

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobile: mobile.SettingsPage(),
      desktop: desktop.SettingsDesktopPage(),
      tablet: desktop.SettingsDesktopPage(),
    );
  }
}
