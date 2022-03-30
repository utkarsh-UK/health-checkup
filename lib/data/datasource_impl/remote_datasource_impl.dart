import 'dart:convert';

import 'package:care_monitor/core/utils/constants.dart';
import 'package:care_monitor/core/utils/exceptions.dart';
import 'package:care_monitor/data/datasources/remote_data_source.dart';
import 'package:care_monitor/data/models/medication_modal.dart';
import 'package:care_monitor/data/services/storage_service.dart';

/// Implments [RemoteDataSource], communicating with remote data such as API/Firebase.
/// 
/// Requires [StorageService] for reading and writing to device storage.
class RemoteDatasourceImpl extends RemoteDataSource {
  final StorageService _service;

  RemoteDatasourceImpl(this._service);

  /// Returns list of [MedicationModel] objects fetched from device storage.
  /// 
  /// Throws [Exception] in case of failure.
  List<MedicationModel> _readMedications() {
    try {
      List<MedicationModel> medications = [];
      if (_service.read(Constants.medStorageKey).toString().isNotEmpty) {
        jsonDecode(_service.read(Constants.medStorageKey).toString())
            .forEach((med) => medications.add(MedicationModel.fromJSON(med)));
      }

      return medications;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Writes list of [MedicationModel] objects to device storage.
  /// 
  /// Throws [Exception] in case of failure.
  void _writeMedications(List<MedicationModel> medications) {
    try {
      _service.write(Constants.medStorageKey, jsonEncode(medications));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> addMedication(MedicationModel medication) async {
    try {
      /* **** Network Call if API is implemented

     final response = await http.post(
        BASE_URL + '/add-medication/:${medication.medicationID}',
        body: jsonEncode(medication),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ); 

      Parse the response.body with jsonDecode as done with readMedications() method.
      Adding delay for mocking network call delay.

      *** */

      await Future.delayed(const Duration(milliseconds: 400));

      final medications = _readMedications();

      medications.add(medication);
      _writeMedications(medications);
    } catch (e) {
      // Loggers can be added here for analyzation.
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> deleteMedication(String medicationID) async {
    try {
      /* **** Network Call if API is implemented

     final response = await http.delete(
        BASE_URL + '/delete-medication/:${medication.medicationID}',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ); 

      Parse the response.body with jsonDecode as done with readMedications() method. 
      Adding delay for mocking network call delay.

      *** */

      await Future.delayed(const Duration(milliseconds: 400));

      final medications = _readMedications();

      medications.removeWhere((med) => med.medicationID == medicationID);
      _writeMedications(medications);

      // Since data is deleted from local, assuming no issues and return true always.
      return true;
    } catch (e) {
      // Loggers can be added here for analyzation.
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> editMedication(
      String medicationID, MedicationModel medication) async {
    try {
      /* **** Network Call if API is implemented

     final response = await http.put(
        BASE_URL + '/edit-medication/:$medicationID',
        body: jsonEncode(medication),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ); 

      Parse the response.body with jsonDecode as done with readMedications() method. 
      Adding delay for mocking network call delay.

      *** */

      await Future.delayed(const Duration(milliseconds: 600));

      final medications = _readMedications();

      int oldIndex = medications.indexOf(
          medications.firstWhere((med) => med.medicationID == medicationID));
      medications.removeAt(oldIndex);
      medications.insert(oldIndex, medication);

      _writeMedications(medications);

      // Since data is edited from local, assuming no errors and always return true.
      return true;
    } catch (e) {
      // Loggers can be added here for analyzation.
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<MedicationModel>> fetchAllMedicines() async {
    try {
      /* **** Network Call if API is implemented

     final response = await http.get(
        BASE_URL + '/fetch-all',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ); 

      Parse the response.body with jsonDecode as done with readMedications() method. 
      Adding delay for mocking network call delay.

      *** */

      await Future.delayed(const Duration(milliseconds: 500));

      return _readMedications();
    } catch (e) {
      // Loggers can be added here for analyzation.
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<String>> searchMedication(String medicationName) async {
    try {
      /* **** Network Call if API is implemented

     final response = await http.get(
        BASE_URL + '/search-medication?query',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ); 

      Parse the response.body with jsonDecode as done with readMedications() method. 
      Adding delay for mocking network call delay.

      *** */

      await Future.delayed(const Duration(milliseconds: 200));

      return Constants.availableMeds
          .where(
              (med) => med.toLowerCase().contains(medicationName.toLowerCase()))
          .toList();
    } catch (e) {
      // Loggers can be added here for analyzation.
      throw ServerException(message: e.toString());
    }
  }
}
