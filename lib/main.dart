import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/localization/app_translations.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/services/app_language_service.dart';
import 'app/theme/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

  if (supabaseUrl == null ||
      supabaseUrl.isEmpty ||
      supabaseAnonKey == null ||
      supabaseAnonKey.isEmpty) {
    throw StateError('Supabase configuration is missing');
  }

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  final languageService = await AppLanguageService().init();

  Get.put<AppLanguageService>(languageService, permanent: true);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(KimiaXploreApp(initialLocale: languageService.locale));
}

class KimiaXploreApp extends StatelessWidget {
  const KimiaXploreApp({super.key, required this.initialLocale});

  final Locale initialLocale;

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;

    return GetMaterialApp(
      title: 'KimiaXplore',
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: initialLocale,
      fallbackLocale: const Locale('id', 'ID'),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      initialRoute: session != null ? AppRoutes.home : AppRoutes.welcome,
      getPages: AppPages.pages,
    );
  }
}
