import 'package:get/get.dart';

import '../../ai_tutor/controllers/ai_tutor_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../lab/controllers/lab_controller.dart';
import '../../shop/controllers/shop_controller.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());

    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);

    Get.lazyPut<LabController>(() => LabController(), fenix: true);

    Get.lazyPut<AiTutorController>(() => AiTutorController(), fenix: true);

    Get.lazyPut<ShopController>(() => ShopController(), fenix: true);
  }
}
