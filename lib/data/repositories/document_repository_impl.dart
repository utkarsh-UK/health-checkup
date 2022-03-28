import 'package:care_monitor/core/utils/exceptions.dart';
import 'package:care_monitor/data/datasources/local_data_source.dart';
import 'package:care_monitor/data/models/document_modal.dart';
import 'package:care_monitor/domain/entities/document.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:care_monitor/domain/repositories/document_repository.dart';
import 'package:dartz/dartz.dart';

class DocumentRepositoryImpl extends DocumentRepository {
  final LocalDataSource _localDataSource;

  DocumentRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, void>> deleteDocument(String documentID) async {
    try {
      return Right(await _localDataSource.deleteDocument(documentID));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Document>>> getDocuments() async {
    try {
      return Right(await _localDataSource.getDocuments());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveDocument(Document document) async {
    try {
      return Right(
        await _localDataSource
            .saveDocument(DocumentModel.copyFromDocument(document)),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
