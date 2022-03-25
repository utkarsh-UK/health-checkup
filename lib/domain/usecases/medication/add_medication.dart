import 'package:care_monitor/core/usecases/usecase.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/medication_repository.dart';

class AddMedication implements UseCase<void, Params> {
  final MedicationRepository _repository;

  AddMedication(this._repository);

  @override
  Future<Either<Failure, void>> call(Params params) {
    return _repository.addMedication(params.medication!);
  }
}
