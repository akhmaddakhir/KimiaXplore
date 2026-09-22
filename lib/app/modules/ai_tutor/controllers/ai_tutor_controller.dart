import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/gemini_service.dart';
import '../models/ai_chat_message.dart';

class AiTutorController extends GetxController {
  final GeminiService _geminiService = GeminiService();

  final messages = <AiChatMessage>[].obs;

  final isChatOpen = false.obs;
  final isSending = false.obs;

  Future<void> sendMessage(String message) async {
    final text = message.trim();

    if (text.isEmpty || isSending.value) {
      return;
    }

    messages.add(AiChatMessage(text: text, isUser: true));

    isChatOpen.value = true;
    isSending.value = true;

    try {
      final reply = await _geminiService.generateReply(
        List<AiChatMessage>.from(messages),
      );

      messages.add(AiChatMessage(text: reply, isUser: false));
    } catch (_) {
      messages.add(
        const AiChatMessage(
          text:
              'Maaf, Kimi belum bisa menjawab sekarang. Periksa koneksi internet dan konfigurasi Gemini API lalu coba lagi.',
          isUser: false,
        ),
      );
    } finally {
      isSending.value = false;
    }
  }

  void openNewChat() {
    if (isSending.value) {
      return;
    }

    messages.clear();
    isChatOpen.value = false;
  }

  void openAttachment() {
    Get.snackbar(
      'Foto soal',
      'Fitur analisis foto soal akan ditambahkan setelah chat teks selesai.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  void openHistory() {
    Get.snackbar(
      'Riwayat Chat',
      'Riwayat percakapan akan ditambahkan nanti.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }
}
