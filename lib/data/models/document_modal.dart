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

  factory DocumentModel.fromJSON(Map<String, dynamic> json) => DocumentModel(
        documentID: json['document_id'],
        documentName: json['document_name'],
        documentPath: json['document_path'],
        documentType: json['document_type'],
        documentSize: json['document_size'],
        addedDate: DateTime.parse(json['added_date']),
      );

  DocumentModel copyWith({
    String? documentID,
    String? documentName,
    String? documentPath,
    String? documentType,
    String? documentSize,
    DateTime? addedDate,
  }) =>
      DocumentModel(
        documentID: documentID ?? this.documentID,
        documentName: documentName ?? this.documentName,
        documentPath: documentPath ?? this.documentPath,
        documentType: documentType ?? this.documentType,
        documentSize: documentSize ?? this.documentSize,
        addedDate: addedDate ?? this.addedDate,
      );

  Map<String, dynamic> toJson() => {
        'document_id': documentID,
        'document_name': documentName,
        'document_path': documentPath,
        'document_type': documentType,
        'document_size': documentSize,
        'added_date': addedDate.toIso8601String(),
      };

  @override
  List<Object?> get props => [documentID, documentName, documentPath];
}
