import 'package:care_monitor/core/usecases/usecase.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/medication_repository.dart';

class SearchMedication implements UseCase<List<String>, Params> {
  final MedicationRepository _repository;

  SearchMedication(this._repository);

  @override
  Future<Either<Failure, List<String>>> call(Params params) {
    return _repository.searchMedication(params.medicationName!);
  }
}
