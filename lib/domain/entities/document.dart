import 'package:equatable/equatable.dart';

class Document extends Equatable {
  final String documentID;
  final String documentName;
  final String documentPath;
  final DateTime addedDate;
  final String documentType;
  final String documentSize;

  const Document({
    required this.documentID,
    required this.documentName,
    required this.documentPath,
    required this.documentType,
    required this.documentSize,
    required this.addedDate,
  });

  @override
  List<Object?> get props => [documentID, documentName, documentPath];
}
