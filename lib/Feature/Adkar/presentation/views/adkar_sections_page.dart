import 'package:flutter/material.dart';
import 'package:Ajr/Feature/Adkar/presentation/views/mobile/adkar_sections_page.dart'
    as mobile;
import 'package:Ajr/Feature/Adkar/presentation/views/desktop/adkar_sections_page.dart'
    as desktop;

class AdkarSectionsPage extends StatelessWidget {
  const AdkarSectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use desktop layout for screens wider than 600px
        if (constraints.maxWidth > 600) {
          return const desktop.AdkarSectionsPage();
        } else {
          return const mobile.AdkarSectionsPage();
        }
      },
    );
  }
}
