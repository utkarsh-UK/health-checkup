import 'package:care_monitor/domain/usecases/medication/add_medication.dart';
import 'package:care_monitor/domain/usecases/medication/delete_medication.dart';
import 'package:care_monitor/domain/usecases/medication/edit_medication.dart';
import 'package:care_monitor/domain/usecases/medication/fetch_medications.dart';
import 'package:care_monitor/domain/usecases/medication/search_medication.dart';
import 'package:care_monitor/presentation/screens/home/controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  final addMed = Get.find<AddMedication>();
  final editMed = Get.find<EditMedication>();
  final deleteMed = Get.find<DeleteMedication>();
  final searchMed = Get.find<SearchMedication>();
  final fetchMed = Get.find<FetchMedication>();

  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        addMedication: addMed,
        editMedication: editMed,
        deleteMedication: deleteMed,
        searchMedication: searchMed,
        fetchMedication: fetchMed,
      ),
    );
  }
}
