import 'package:care_monitor/domain/entities/medication.dart';
import 'package:care_monitor/presentation/screens/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMedicationController extends GetxController {
  final HomeController _homeController = Get.find<HomeController>();

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final classController = TextEditingController();
  final brandController = TextEditingController();
  final codeController = TextEditingController();
  final typeController = TextEditingController();
  final strengthController = TextEditingController();
  final formController = TextEditingController();
  final routeController = TextEditingController();
  final doseController = TextEditingController();
  final intructionsController = TextEditingController();
  final reasonController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    print("Controller initialized");
  }

  @override
  void onClose() {
    super.onClose();

    nameController.dispose();
    classController.dispose();
    codeController.dispose();
    brandController.dispose();
    typeController.dispose();
    strengthController.dispose();
    formController.dispose();
    routeController.dispose();
    doseController.dispose();
    intructionsController.dispose();
    reasonController.dispose();

    print('Controllers disposed');
  }

  void clearControllers() {
    nameController.clear();
    classController.clear();
    brandController.clear();
    typeController.clear();
    strengthController.clear();
    formController.clear();
    routeController.clear();
    doseController.clear();
    intructionsController.clear();
    reasonController.clear();
  }

  void addMedication() {
    final String name = nameController.text.trim();
    final String drugClass = classController.text.trim();
    final String brand = brandController.text.trim();
    final String code = codeController.text.trim();
    final String type = typeController.text.trim();
    final String strength = strengthController.text.trim();
    final String form = formController.text.trim();
    final String route = routeController.text.trim();
    final int dose = num.parse("2").toInt();
    final List<String> doseHours = ['08:00 PM'];
    final int frequency = 2;
    final String instructions = intructionsController.text.trim();
    final String reason = reasonController.text.trim();

    final Medication med = Medication(
      medicationID: DateTime.now().toIso8601String(),
      medicationName: name,
      drugClass: drugClass,
      drugBrand: brand,
      drugCode: code,
      drugType: type,
      drugStrength: strength,
      form: form,
      adminRoute: route,
      dose: dose,
      doseHours: doseHours,
      frequency: frequency,
      instructions: instructions,
      reason: reason,
      dateAdded: DateTime.now(),
      dateUpdated: DateTime.now(),
    );

    _homeController.addMedication(med);
  }
}
