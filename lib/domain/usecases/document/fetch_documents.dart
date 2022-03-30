import 'package:care_monitor/core/usecases/usecase.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:care_monitor/domain/entities/document.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/document_repository.dart';

/// Usecase for fetching saved documents.
class FetchDocuments implements UseCase<List<Document>, NoParams> {
  final DocumentRepository _repository;

  FetchDocuments(this._repository);

  @override
  Future<Either<Failure, List<Document>>> call(NoParams params) {
    return _repository.getDocuments();
  }
}
