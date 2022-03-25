import 'package:care_monitor/presentation/screens/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicationsTab extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();

  MedicationsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionButton(onPressed: homeController.readMed, child: Icon(Icons.read_more_outlined)),
      body: Obx(
        () => ListView(
            children: homeController.medications
                .map((med) => Text(med.medicationName))
                .toList()),
      ),
    );
  }
}
