import 'package:care_monitor/data/models/medication_modal.dart';

/// Datasource for connecting the application to outside internet world to
/// load and post data.
abstract class RemoteDataSource {
  /// Saves this [medication] to database.
  Future<void> addMedication(MedicationModel medication);

  /// Updates [medication] having [medicationID]. Returns [true] if [medication]
  /// is updated successfully. False, otherwise.
  Future<bool> editMedication(String medicationID, MedicationModel medication);

  /// Deletes the medication with ID [medicationID]. Returns [true]
  /// if medication is deleted successfully. False otherwise.
  Future<bool> deleteMedication(String medicationID);

  /// Returns list of medicines matching name [medicationName].
  Future<List<String>> searchMedication(String medicationName);

  /// Fetch all medications
  Future<List<MedicationModel>> fetchAllMedicines();
}
