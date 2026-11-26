import 'package:get/get.dart';

import '../controllers/teacher_tutor_controller.dart';

class TeacherTutorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherTutorController>(() => TeacherTutorController());
  }
}
