import 'package:care_monitor/core/usecases/usecase.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/medication_repository.dart';

/// Usecase for deleting saved medication.
/// 
/// Requires [medicationID] to be deleted.
class DeleteMedication implements UseCase<bool, Params> {
  final MedicationRepository _repository;

  DeleteMedication(this._repository);

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return _repository.deleteMedication(params.medicineID!);
  }
}
