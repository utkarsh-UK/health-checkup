import 'package:care_monitor/domain/entities/medication.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:care_monitor/domain/repositories/medication_repository.dart';
import 'package:dartz/dartz.dart';

class MedicationRepositoryImpl extends MedicationRepository {
  
  @override
  Future<Either<Failure, void>> addMedication(Medication medication) {
    // TODO: implement addMedication
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteMedication(String medicationID) {
    // TODO: implement deleteMedication
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> editMedication(String medicationID, Medication medication) {
    // TODO: implement editMedication
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Medication>>> fetchAllMedicines() {
    // TODO: implement fetchAllMedicines
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Medication>>> searchMedication(String medicationName) {
    // TODO: implement searchMedication
    throw UnimplementedError();
  }
  
}