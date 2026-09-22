import 'package:get/get.dart';

class AiTutorController extends GetxController {
  final RxList<String> messages = <String>[].obs;

  final RxBool isChatOpen = false.obs;

  void sendMessage(String message) {
    final text = message.trim();

    if (text.isEmpty) {
      return;
    }

    messages.add(text);

    isChatOpen.value = true;
  }

  void openNewChat() {
    messages.clear();

    isChatOpen.value = false;
  }

  void openAttachment() {}

  void openHistory() {}
}
