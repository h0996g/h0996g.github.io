import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noor/Feature/Home/presentation/views/start_page.dart';
import 'package:noor/Feature/Adkar/presentation/views/adkar_sections_page.dart';
import 'package:noor/Feature/Adkar/presentation/views/adkar_details_page.dart';
import 'package:noor/Feature/Quran/presentation/views/surah_list_page.dart';
import 'package:noor/Feature/Quran/presentation/views/surah_detail_page.dart';
import 'package:noor/Feature/NamesOfAllah/presentation/views/names_of_allah_page.dart';
import 'package:noor/Feature/tasbih/presentation/views/tasbih_page.dart';
import 'package:noor/Feature/Settings/presentation/views/settings_page.dart';
import 'package:noor/Feature/Quran/data/models/surah_model.dart';
import 'package:noor/Feature/Quran/presentation/manager/quran_cubit/quran_cubit.dart';
import 'package:noor/Feature/Quran/data/repo/quran_repo.dart';
import 'package:noor/Feature/Adkar/presentation/manager/adkar_cubit.dart';
import 'package:noor/Feature/Adkar/data/repo/adkar_repo.dart';
import 'package:noor/Feature/Quran/presentation/manager/audio_cubit/audio_cubit.dart';

class AppRouter {
  static const String kHome = '/';
  static const String kAdkar = '/adkar';
  static const String kAdkarDetails = '/adkar-details';
  static const String kQuran = '/quran';
  static const String kQuranDetails = '/quran-details';
  static const String kNamesOfAllah = '/names-of-allah';
  static const String kTasbih = '/tasbih';
  static const String kSettings = '/settings';

  static final router = GoRouter(
    initialLocation: kHome,
    routes: [
      GoRoute(path: kHome, builder: (context, state) => const StartPage()),
      GoRoute(
        path: kSettings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: kQuran,
        builder: (context, state) => BlocProvider(
          create: (context) => QuranCubit(QuranRepository())..loadQuranData(),
          child: const SurahListPage(),
        ),
      ),
      GoRoute(
        path: kQuranDetails,
        builder: (context, state) {
          final surah = state.extra as SurahModel;
          return BlocProvider(
            create: (context) => AudioCubit(),
            child: SurahDetailPage(surah: surah),
          );
        },
      ),
      GoRoute(
        path: kAdkar,
        builder: (context, state) => BlocProvider(
          create: (context) => AdkarCubit(AdkarRepository())..loadSections(),
          child: const AdkarSectionsPage(),
        ),
      ),
      GoRoute(
        path: kAdkarDetails,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return BlocProvider(
            create: (context) => AdkarCubit(AdkarRepository()),
            child: AdkarDetailsPage(
              sectionId: extra['sectionId'] as int,
              sectionName: extra['sectionName'] as String,
            ),
          );
        },
      ),
      GoRoute(
        path: kNamesOfAllah,
        builder: (context, state) => const NamesOfAllahPage(),
      ),
      GoRoute(path: kTasbih, builder: (context, state) => const TasbihPage()),
    ],
  );
}
