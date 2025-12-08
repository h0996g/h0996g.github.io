import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/utils/app_utils.dart';
import 'package:noor/Feature/Home/data/repo/home_repo.dart';
import 'package:noor/Feature/Home/presentation/manager/bottom_player_cubit.dart';
import 'package:noor/Feature/Home/presentation/views/start_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:noor/Feature/Settings/presentation/manager/settings_cubit.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

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
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  BottomPlayerCubit(HomeRepository(Supabase.instance.client)),
            ),
            BlocProvider(create: (context) => SettingsCubit()),
          ],
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Noor',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(useMaterial3: true),
                locale: const Locale('ar', 'SA'),
                supportedLocales: const [
                  Locale('ar', 'SA'),
                  Locale('en', 'US'),
                ],
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: TextScaler.linear(state.textScaleFactor),
                    ),
                    child: child!,
                  );
                },
                home: const StartPage(),
              );
            },
          ),
        );
      },
    );
  }
}
