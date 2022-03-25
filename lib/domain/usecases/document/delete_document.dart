import 'package:care_monitor/core/usecases/usecase.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/document_repository.dart';

class DeleteDocument implements UseCase<void, Params> {
  final DocumentRepository _repository;

  DeleteDocument(this._repository);

  @override
  Future<Either<Failure, void>> call(Params params) {
    return _repository.deleteDocument(params.documentID!);
  }
}
