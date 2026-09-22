import 'package:get/get.dart';

import '../../profile/controllers/profile_controller.dart';

class MainController extends GetxController {
  final selectedIndex = 0.obs;

  void changeTab(int index) {
    if (index < 0 || index > 4) {
      return;
    }

    if (selectedIndex.value == index) {
      if (index == 4) {
        _refreshProfile();
      }

      return;
    }

    selectedIndex.value = index;

    if (index == 4) {
      _refreshProfile();
    }
  }

  void _refreshProfile() {
    if (!Get.isRegistered<ProfileController>()) {
      return;
    }

    final profileController = Get.find<ProfileController>();

    profileController.loadUser();
    profileController.loadProfileProgress();
  }
}
