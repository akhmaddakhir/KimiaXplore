import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/simulation_controller.dart';

class SimulationView extends GetView<SimulationController> {
  const SimulationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SimulationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SimulationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
