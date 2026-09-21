import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/topic_controller.dart';

class TopicView extends GetView<TopicController> {
  const TopicView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TopicView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TopicView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
