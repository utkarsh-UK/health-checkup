import 'package:care_monitor/domain/usecases/document/delete_document.dart';
import 'package:care_monitor/domain/usecases/document/fetch_documents.dart';
import 'package:care_monitor/domain/usecases/document/save_document.dart';
import 'package:care_monitor/presentation/screens/documents/documents_controller.dart';
import 'package:get/get.dart';

class DocumentsBinding extends Bindings {
  final _saveDocument = Get.find<SaveDocument>();
  final _fetchDocuments = Get.find<FetchDocuments>();
  final _deleteDocuments = Get.find<DeleteDocument>();

  @override
  void dependencies() {
    Get.lazyPut(
      () => DocumentsController(
        saveDocument: _saveDocument,
        deleteDocument: _deleteDocuments,
        fetchDocuments: _fetchDocuments,
      ),
    );
  }
}
