import 'package:get/get.dart';

import '../data/home_topics.dart';
import '../models/topic_model.dart';

class HomeController extends GetxController {
  final studyProgress = 0.obs;
  final topics = <TopicModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTopics();
  }

  void loadTopics() {
    topics.assignAll(HomeTopics.items);
  }

  void onTopicSelected(TopicModel topic) {
    // Aksi ketika topik dipilih
  }
}
