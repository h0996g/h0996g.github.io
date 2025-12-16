import 'package:flutter/material.dart';
import '../../../../Core/widgets/responsive_widget.dart';
import 'mobile/start_page_mobile.dart';
import 'desktop/start_page_desktop.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobile: StartPageMobile(),
      desktop: StartPageDesktop(),
      tablet: StartPageDesktop(),
    );
  }
}
