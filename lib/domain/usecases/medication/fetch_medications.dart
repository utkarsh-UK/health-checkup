import 'package:care_monitor/core/usecases/usecase.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:care_monitor/domain/entities/medication.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/medication_repository.dart';

class FetchMedication implements UseCase<List<Medication>, NoParams> {
  final MedicationRepository _repository;

  FetchMedication(this._repository);

  @override
  Future<Either<Failure, List<Medication>>> call(NoParams params) {
    return _repository.fetchAllMedicines();
  }
}
