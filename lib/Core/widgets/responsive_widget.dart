import 'package:flutter/material.dart';
import 'package:Ajr/Core/utils/device_type_query.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveWidget({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (DeviceTypeQuery.isDesktop(context) && desktop != null) {
      return desktop!;
    } else if (DeviceTypeQuery.isTablet(context) && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
