import 'package:care_monitor/core/utils/failure.dart';
import 'package:care_monitor/domain/entities/document.dart';
import 'package:dartz/dartz.dart';

abstract class DocumentRepository {
  /// Saves the [document] to storage and returns the [String] path.
  Future<Either<Failure, String>> saveDocument(Document document);

  ///Deletes the document with ID [documentID].
  Future<Either<Failure, void>> deleteDocument(String documentID);

  /// Fetches all the documents from storage
  Future<Either<Failure, List<Document>>> getDocuments();
}
