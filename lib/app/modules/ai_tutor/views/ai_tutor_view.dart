import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ai_tutor_controller.dart';

class AiTutorView extends GetView<AiTutorController> {
  const AiTutorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AiTutorView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AiTutorView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
