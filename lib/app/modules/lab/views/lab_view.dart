import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lab_controller.dart';

class LabView extends GetView<LabController> {
  const LabView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LabView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LabView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
