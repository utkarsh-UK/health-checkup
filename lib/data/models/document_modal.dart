// ignore_for_file: annotate_overrides, overridden_fields

import 'package:care_monitor/domain/entities/document.dart';

class DocumentModel extends Document {
  final String documentID;
  final String documentName;
  final String documentPath;
  final DateTime addedDate;
  final String documentType;
  final String documentSize;

  const DocumentModel({
    required this.documentID,
    required this.documentName,
    required this.documentPath,
    required this.documentType,
    required this.documentSize,
    required this.addedDate,
  }) : super(
          addedDate: addedDate,
          documentID: documentID,
          documentName: documentName,
          documentPath: documentPath,
          documentSize: documentSize,
          documentType: documentType,
        );

  @override
  List<Object?> get props => [documentID, documentName, documentPath];
}
