import 'package:flutter/material.dart';
import '../../../../Core/widgets/responsive_widget.dart';
import 'mobile/adkar_details_page.dart' as mobile;
import 'desktop/adkar_details_page.dart' as desktop;

class AdkarDetailsPage extends StatelessWidget {
  final int sectionId;
  final String sectionName;

  const AdkarDetailsPage({
    super.key,
    required this.sectionId,
    required this.sectionName,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: mobile.AdkarDetailsPage(
        sectionId: sectionId,
        sectionName: sectionName,
      ),
      desktop: desktop.AdkarDetailsPage(
        sectionId: sectionId,
        sectionName: sectionName,
      ),
      tablet: desktop.AdkarDetailsPage(
        sectionId: sectionId,
        sectionName: sectionName,
      ),
    );
  }
}
