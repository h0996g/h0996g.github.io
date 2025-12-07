import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/utils/app_utils.dart';
import 'package:noor/Feature/Home/data/repo/home_repo.dart';
import 'package:noor/Feature/Home/presentation/manager/bottom_player_cubit.dart';
import 'package:noor/Feature/Home/presentation/views/start_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await AppUtils.initializeApp();
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
        return BlocProvider(
          create: (context) =>
              BottomPlayerCubit(HomeRepository(Supabase.instance.client)),
          child: MaterialApp(
            title: 'Noor',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: true),
            home: const StartPage(),
          ),
        );
      },
    );
  }
}
