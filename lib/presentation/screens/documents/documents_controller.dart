import 'dart:io';

import 'package:care_monitor/core/usecases/usecase.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:care_monitor/domain/entities/document.dart';
import 'package:care_monitor/domain/usecases/document/delete_document.dart';
import 'package:care_monitor/domain/usecases/document/fetch_documents.dart';
import 'package:care_monitor/domain/usecases/document/save_document.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/extensions.dart';

class DocumentsController extends GetxController {
  final FetchDocuments _fetchDocuments;
  final SaveDocument _saveDocument;
  final DeleteDocument _deleteDocument;

  final currentPickedFile = Rx<File?>(null);
  final currentDocument = Rx<Document?>(null);
  final savedDocuments = <Document>[].obs;

  DocumentsController({
    required FetchDocuments fetchDocuments,
    required SaveDocument saveDocument,
    required DeleteDocument deleteDocument,
  })  : _fetchDocuments = fetchDocuments,
        _saveDocument = saveDocument,
        _deleteDocument = deleteDocument;

  @override
  void onInit() {
    super.onInit();

    getDocuments();
  }

  @override
  void onClose() {
    super.onClose();

    _clearFileCache();
  }

  void setCurrentPickedFile(
      [List<String> extensions = const ['png', 'jpg', 'pdf', 'doc']]) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['png', 'jpg', 'pdf', 'doc'],
      dialogTitle: 'Choose File',
      type: FileType.custom,
    );

    if (result != null) {
      final pickedFile = result.files.single;

      currentPickedFile.value = File(pickedFile.path!);
      currentDocument.value = Document(
        documentID: DateTime.now().toIso8601String(),
        documentName: pickedFile.name.split(".").first,
        documentPath: pickedFile.path!,
        documentType: pickedFile.extension!,
        documentSize: pickedFile.size.sizeInHigherBytes,
        addedDate: DateTime.now(),
      );

      saveDocument(currentDocument.value!);
    } else {
      Get.snackbar('Cancelled', 'You have cancelled file picker');
    }
  }

  void captureImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image != null) {
      currentPickedFile.value = File(image.path);
      currentDocument.value = Document(
        documentID: DateTime.now().toIso8601String(),
        documentName: image.name.split(".").first,
        documentPath: image.path,
        documentType: image.name.split(".").last,
        documentSize: currentPickedFile.value!.lengthSync().sizeInHigherBytes,
        addedDate: DateTime.now(),
      );
    } else {
      Get.snackbar('Cancelled', 'You have cancelled image picker');
    }
  }

  void getDocuments() async {
    final failureOrList = await _fetchDocuments(NoParams());

    // Unfold the Either object to extract Failure or result.
    failureOrList.fold(
      (Failure fail) {
        if (fail is ServerFailure) {
          print(fail.message);
        }
      },
      (docList) {
        savedDocuments.assignAll(docList);
      },
    );
  }

  void saveDocument(Document document) async {
    final failureOrList = await _saveDocument(Params(document: document));

    // Unfold the Either object to extract Failure or result.
    failureOrList.fold(
      (Failure fail) {
        if (fail is ServerFailure) {
          print(fail.message);
          Get.snackbar('Error', 'Saving the document failed!');
        }
      },
      (path) {
        // Get.snackbar('Success', 'You have successfully updated the medication');
        Get.defaultDialog(
            title: 'Success', middleText: 'Document was saved to path $path');
        getDocuments();
      },
    );
  }

  void deleteDocument(String documentID) async {
    final failureOrList = await _deleteDocument(Params(documentID: documentID));

    // Unfold the Either object to extract Failure or result.
    failureOrList.fold(
      (Failure fail) {
        if (fail is ServerFailure) {
          Get.snackbar('Error', 'Saving the document failed!');
        }
      },
      (_) {
        // Get.snackbar('Success', 'You have successfully updated the medication');
        Get.defaultDialog(title: 'Success', middleText: 'Document was deleted');
        getDocuments();
      },
    );
  }

  void _clearFileCache() async {
    await FilePicker.platform.clearTemporaryFiles();
  }
}
