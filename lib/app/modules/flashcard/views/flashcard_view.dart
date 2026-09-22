import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/flashcard_controller.dart';

class FlashcardView extends GetView<FlashcardController> {
  const FlashcardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlashcardView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FlashcardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
