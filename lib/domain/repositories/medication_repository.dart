import 'package:care_monitor/core/utils/failure.dart';
import 'package:care_monitor/domain/entities/medication.dart';
import 'package:dartz/dartz.dart';

abstract class MedicationRepository {
  /// Saves this [medication] to database.
  Future<Either<Failure, void>> addMedication(Medication medication);

  /// Updates [medication] having [medicationID]. Returns [true] if [medication]
  /// is updated successfully. False, otherwise.
  Future<Either<Failure, bool>> editMedication(
      String medicationID, Medication medication);

  /// Deletes the medication with ID [medicationID]. Returns [true]
  /// if medication is deleted successfully. False otherwise.
  Future<Either<Failure, bool>> deleteMedication(String medicationID);

  /// Returns list of medicines matching name [medicationName].
  Future<Either<Failure, List<String>>> searchMedication(String medicationName);

  /// Fetch all medications
  Future<Either<Failure, List<Medication>>> fetchAllMedicines();
}
