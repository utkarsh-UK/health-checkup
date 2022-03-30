import 'package:care_monitor/core/usecases/usecase.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/document_repository.dart';

/// Usecase for saving the document.
/// 
/// Requires [document] to be saved.
class SaveDocument implements UseCase<String, Params> {
  final DocumentRepository _repository;

  SaveDocument(this._repository);

  @override
  Future<Either<Failure, String>> call(Params params) {
    return _repository.saveDocument(params.document!);
  }
}
