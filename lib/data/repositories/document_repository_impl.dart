import 'package:care_monitor/domain/entities/document.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:care_monitor/domain/repositories/document_repository.dart';
import 'package:dartz/dartz.dart';

class DocumentRepositoryImpl extends DocumentRepository {
  @override
  Future<Either<Failure, void>> deleteDocument(String documentID) {
    // TODO: implement deleteDocument
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Document>>> getDocuments() {
    // TODO: implement getDocuments
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> saveDocument(Document document) {
    // TODO: implement saveDocument
    throw UnimplementedError();
  }
}
