import 'package:care_monitor/data/datasources/remote_data_source.dart';
import 'package:care_monitor/data/models/medication_modal.dart';

class RemoteDatasourceImpl extends RemoteDataSource {
  @override
  Future<void> addMedication(MedicationModel medication) {
    // TODO: implement addMedication
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteMedication(String medicationID) {
    // TODO: implement deleteMedication
    throw UnimplementedError();
  }

  @override
  Future<bool> editMedication(String medicationID, MedicationModel medication) {
    // TODO: implement editMedication
    throw UnimplementedError();
  }

  @override
  Future<List<MedicationModel>> fetchAllMedicines() {
    // TODO: implement fetchAllMedicines
    throw UnimplementedError();
  }

  @override
  Future<List<MedicationModel>> searchMedication(String medicationName) {
    // TODO: implement searchMedication
    throw UnimplementedError();
  }
  
}