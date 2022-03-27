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

  final medication = Rx<Medication?>(null);
  final noOfDoses = 1.obs;
  final doseType = "".obs;
  final frequencyPeriod = "".obs;
  final firstMeridian = "AM".obs;
  final secondMeridian = "AM".obs;
  final thirdMeridian = "AM".obs;
  final doseHours = <String>["00:00", "00:00", "00:00"].obs;

  @override
  void onInit() {
    super.onInit();

    ever(
      medication,
      (Medication? med) {
        nameController.text = med?.medicationName ?? "";
        classController.text = med?.drugClass ?? "";
        brandController.text = med?.drugBrand ?? "";
        codeController.text = med?.drugCode ?? "";
        typeController.text = med?.drugType ?? "";
        strengthController.text = med?.drugStrength ?? "";
        formController.text = med?.form ?? "";
        routeController.text = med?.adminRoute ?? "";
        doseController.text = '${med?.dose ?? ""}';
        intructionsController.text = med?.instructions ?? "";
        reasonController.text = med?.reason ?? "";
      },
      condition: () => medication.value != null,
    );
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
    final int dose = int.parse(doseController.text.trim());
    final List<String> hours = doseHours;
    final int frequency = noOfDoses.value;
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

  void setCurrentMedication(Medication? med) {
    medication.value = med;
  }

  void setNoOfDoses(int value) {
    noOfDoses.value = value;
  }

  void setDoseType(String value) {
    doseType.value = '${doseController.text} ${doseType.value}';
  }

  void setFrequencyPeriod(String value) {
    frequencyPeriod.value = value;
  }

  void setDoseHours(List<String> value) {
    doseHours.value = value;
  }

  void setFirstMeridian(String value) {
    firstMeridian.value = value;
  }

  void setSecondMeridian(String value) {
    secondMeridian.value = value;
  }

  void setThirdMeridian(String value) {
    thirdMeridian.value = value;
  }

  void addDoseHours(int index, String value) {
    doseHours[index] = value;
  }
}
