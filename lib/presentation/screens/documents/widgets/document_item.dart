import 'dart:io';

import 'package:care_monitor/domain/entities/document.dart';
import 'package:care_monitor/presentation/screens/documents/documents_controller.dart';
import 'package:care_monitor/presentation/screens/documents/view/view_document_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/extensions.dart';

class DocumentItem extends StatelessWidget {
  final Document document;

  const DocumentItem(this.document, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => Get.to(() => ViewDocumentView(document)),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0.wp, vertical: 2.0.wp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              offset: const Offset(0, 1),
              blurRadius: 2.0,
              spreadRadius: 1.0,
            )
          ],
        ),
        child: ListTile(
          isThreeLine: true,
          tileColor: Colors.white,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 2.0.wp, vertical: 2.0.wp),
          leading: Container(
            padding: EdgeInsets.symmetric(horizontal: 1.0.wp),
            height: 35.0.wp,
            width: 20.0.wp,
            alignment: Alignment.center,
            child: (document.documentType.toLowerCase() == 'jpg' ||
                    document.documentType.toLowerCase() == 'png')
                ? Image.file(File(document.documentPath), fit: BoxFit.cover)
                : Icon(FontAwesome5.file_pdf, size: 15.0.wp),
          ),
          title: Text(
            document.documentName,
            style: textTheme.bodyText2!
                .copyWith(fontSize: 16.0.sp, fontWeight: FontWeight.w400),
          ),
          subtitle: Column(
            children: [
              SizedBox(height: 1.0.wp),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    document.documentType.toUpperCase(),
                    style: textTheme.bodyText2!.copyWith(fontSize: 12.0.sp),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.0.wp),
                    width: 6.0,
                    height: 6.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    document.documentSize,
                    style: textTheme.bodyText2!.copyWith(fontSize: 12.0.sp),
                  ),
                ],
              ),
              SizedBox(height: 3.0.wp),
              FittedBox(
                child: Text(
                  'Uploaded on : ${DateFormat('d MMM yyyy').format(document.addedDate)}',
                  style: textTheme.bodyText2!.copyWith(fontSize: 12.0.sp),
                ),
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () => Get.find<DocumentsController>()
                .confirmDeletion(document.documentID, context),
            icon: Icon(FontAwesome5.trash_alt, size: 6.0.wp),
          ),
        ),
      ),
    );
  }
}
