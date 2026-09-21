import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/material_controller.dart';

class MaterialView extends GetView<MaterialController> {
  const MaterialView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaterialView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MaterialView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
