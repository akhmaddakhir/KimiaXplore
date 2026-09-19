import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(const KimiaXploreApp());
}

class KimiaXploreApp extends StatelessWidget {
  const KimiaXploreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KimiaXplore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.onboarding,
      getPages: AppPages.pages,
    );
  }
}
