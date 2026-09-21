import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/shop_controller.dart';

class ShopView extends GetView<ShopController> {
  const ShopView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ShopView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
