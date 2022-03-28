import 'dart:convert';

import 'package:care_monitor/core/utils/constants.dart';
import 'package:care_monitor/core/utils/exceptions.dart';
import 'package:care_monitor/data/datasources/local_data_source.dart';
import 'package:care_monitor/data/models/document_modal.dart';
import 'package:care_monitor/data/services/storage_service.dart';

class LocalDatasourceImpl extends LocalDataSource {
  final StorageService _service;

  LocalDatasourceImpl(this._service);

  List<DocumentModel> _readDocuments() {
    // try {
      List<DocumentModel> documents = [];
      if (_service.read(Constants.docStorageKey).toString().isNotEmpty) {
        jsonDecode(_service.read(Constants.docStorageKey).toString())
            .forEach((doc) => documents.add(DocumentModel.fromJSON(doc)));
      }

      return documents;
    // } catch (e) {
    //   throw Exception(e.toString());
    // }
  }

  void _writeDocuments(List<DocumentModel> documents) {
    // try {
      _service.write(Constants.docStorageKey, jsonEncode(documents));
    // } catch (e) {
    //   throw Exception(e.toString());
    // }
  }

  @override
  Future<void> deleteDocument(String documentID) async {
    try {
      final savedDocuments = await getDocuments();

      savedDocuments.removeWhere((doc) => doc.documentID == documentID);
      _writeDocuments(savedDocuments);
    } catch (e) {
      // Loggers can be added here for analyzation.
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<DocumentModel>> getDocuments() async {
    try {
      return _readDocuments();
    } catch (e) {
      // Loggers can be added here for analyzation.
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> saveDocument(DocumentModel document) async {
    // try {
      final savedDocuments = await getDocuments();

      savedDocuments.add(document);
      _writeDocuments(savedDocuments);

      return document.documentPath;
    // } catch (e) {
    //   // Loggers can be added here for analyzation.
    //   throw ServerException(message: e.toString());
    // }
  }
}
