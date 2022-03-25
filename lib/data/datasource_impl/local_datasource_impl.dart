import 'package:care_monitor/data/datasources/local_data_source.dart';
import 'package:care_monitor/data/models/document_modal.dart';

class LocalDatasourceImpl extends LocalDataSource {
  @override
  Future<void> deleteDocument(String documentID) {
    // TODO: implement deleteDocument
    throw UnimplementedError();
  }

  @override
  Future<List<DocumentModel>> getDocuments() {
    // TODO: implement getDocuments
    throw UnimplementedError();
  }

  @override
  Future<String> saveDocument(DocumentModel document) {
    // TODO: implement saveDocument
    throw UnimplementedError();
  }
  
}