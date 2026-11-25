import 'package:get/get.dart';

import '../../profile/controllers/profile_controller.dart';

class MainController extends GetxController {
  final selectedIndex = 0.obs;
  final isMoreMenuOpen = false.obs;

  void changeTab(int index) {
    if (index < 0 || index > 4) {
      return;
    }

    if (index == 4) {
      isMoreMenuOpen.value = !isMoreMenuOpen.value;
      return;
    }

    isMoreMenuOpen.value = false;
    if (selectedIndex.value != index) {
      selectedIndex.value = index;
    }
  }

  void closeMoreMenu() {
    if (isMoreMenuOpen.value) {
      isMoreMenuOpen.value = false;
    }
  }

  void refreshProfile() {
    if (!Get.isRegistered<ProfileController>()) {
      return;
    }

    final profileController = Get.find<ProfileController>();
    profileController.loadUser();
    profileController.loadProfileProgress();
  }
}
