import 'package:get/get.dart';

class MainController extends GetxController {
  final selectedIndex = 0.obs;

  void changeTab(int index) {
    if (index < 0 || index > 4) return;

    if (selectedIndex.value == index) return;

    selectedIndex.value = index;
  }
}
