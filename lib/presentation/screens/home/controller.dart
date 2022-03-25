import 'package:care_monitor/core/usecases/usecase.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:care_monitor/domain/entities/medication.dart';
import 'package:care_monitor/domain/usecases/medication/add_medication.dart';
import 'package:care_monitor/domain/usecases/medication/delete_medication.dart';
import 'package:care_monitor/domain/usecases/medication/edit_medication.dart';
import 'package:care_monitor/domain/usecases/medication/fetch_medications.dart';
import 'package:care_monitor/domain/usecases/medication/search_medication.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AddMedication _addMedication;
  final EditMedication _editMedication;
  final DeleteMedication _deleteMedication;
  final SearchMedication _searchMedication;
  final FetchMedication _fetchMedication;

  HomeController({
    required AddMedication addMedication,
    required EditMedication editMedication,
    required DeleteMedication deleteMedication,
    required SearchMedication searchMedication,
    required FetchMedication fetchMedication,
  })  : _addMedication = addMedication,
        _editMedication = editMedication,
        _deleteMedication = deleteMedication,
        _searchMedication = searchMedication,
        _fetchMedication = fetchMedication;

  @override
  void onReady() {
    super.onReady();

    _addMedication(
      Params(
        medication: Medication(
          medicationID: DateTime.now().toIso8601String(),
          medicationName: 'Cipla',
          drugClass: 'Durg Class',
          drugBrand: 'Brand',
          drugCode: 'Code',
          drugType: 'Type',
          drugStrength: 'Strenht',
          form: 'Form',
          adminRoute: 'Route',
          dose: 2,
          doseHours: const ['8:00 PM'],
          frequency: 2,
          instructions: 'instructions',
          reason: 'reason',
        ),
      ),
    );
  }

  final medications = <Medication>[].obs;

  void readMed() async {
    final failureOrList = await _fetchMedication(NoParams());

    failureOrList.fold(
      (Failure fail) {},
      (list) {
        medications.assignAll(list);
      },
    );
  }
}
