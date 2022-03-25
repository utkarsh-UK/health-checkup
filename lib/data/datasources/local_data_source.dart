import 'package:care_monitor/data/models/document_modal.dart';

/// Communicates with local device/database/location for data.
abstract class LocalDataSource {
  /// Saves the [document] to storage and returns the [String] path.
  Future<String> saveDocument(DocumentModel document);

  ///Deletes the document with ID [documentID].
  Future<void> deleteDocument(String documentID);

  /// Fetches all the documents from storage
  Future<List<DocumentModel>> getDocuments();
}
