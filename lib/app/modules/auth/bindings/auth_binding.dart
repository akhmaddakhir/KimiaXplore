import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  AuthBinding(this.tag);

  final String tag;

  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), tag: tag);
  }
}
