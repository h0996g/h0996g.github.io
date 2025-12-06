import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/api/dio.dart';
import 'package:noor/Core/helper/observer.dart';
import 'package:noor/Feature/Home/presentation/views/start_page.dart';

void main() {
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
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
