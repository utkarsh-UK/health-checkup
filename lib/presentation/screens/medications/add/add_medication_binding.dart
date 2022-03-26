import 'package:care_monitor/presentation/screens/medications/add/add_medication_controller.dart';
import 'package:get/get.dart';

class AddMedicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddMedicationController());
  }
}
