import 'package:get/get.dart';

import '../../home/models/topic_model.dart';
import '../data/material_data.dart';
import '../models/material_model.dart';

class MaterialController extends GetxController {
  final topic = Rxn<TopicModel>();
  final material = Rxn<MaterialModel>();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments is TopicModel) {
      topic.value = Get.arguments as TopicModel;

      material.value = MaterialData.findByTopicId(topic.value!.id);
    }
  }
}
