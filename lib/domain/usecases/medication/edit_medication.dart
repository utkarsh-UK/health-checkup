import 'package:care_monitor/core/usecases/usecase.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/medication_repository.dart';

class EditMedication implements UseCase<bool, Params> {
  final MedicationRepository _repository;

  EditMedication(this._repository);

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return _repository.editMedication(
      params.medicineID!,
      params.medication!,
    );
  }
}
