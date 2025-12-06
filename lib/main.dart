import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/api/dio.dart';
import 'package:noor/Feature/Home/presentation/views/start_page.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone 11 Pro size as base
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Noor',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          home: const StartPage(),
        );
      },
    );
  }
}
