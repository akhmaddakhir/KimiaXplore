import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class WelcomeController extends GetxController {
  void onStartPressed() {
    Get.toNamed(AppRoutes.onboarding);
  }

  void onLoginPressed() {
    Get.toNamed(AppRoutes.login);
  }
}
