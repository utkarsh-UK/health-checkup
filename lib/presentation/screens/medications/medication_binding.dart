import 'package:care_monitor/presentation/screens/medications/medication_controller.dart';
import 'package:get/get.dart';

class MedicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MedicationController());
  }
}
