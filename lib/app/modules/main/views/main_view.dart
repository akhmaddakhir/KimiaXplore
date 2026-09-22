import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/app_bottom_navbar.dart';

import '../../ai_tutor/views/ai_tutor_view.dart';
import '../../home/views/home_view.dart';
import '../../lab/views/lab_view.dart';
import '../../profile/views/profile_view.dart';
import '../../shop/views/shop_view.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  static const List<Widget> _pages = [
    HomeView(),
    LabView(),
    AiTutorView(),
    ShopView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: _pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => AppBottomNavbar(
          selectedIndex: controller.selectedIndex.value,
          onTabSelected: controller.changeTab,
        ),
      ),
    );
  }
}
