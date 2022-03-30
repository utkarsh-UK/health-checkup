import 'dart:io';

import 'package:care_monitor/domain/entities/document.dart';
import 'package:care_monitor/presentation/screens/documents/documents_controller.dart';
import 'package:care_monitor/presentation/widgets/bottom_nav_bar.dart';
import 'package:care_monitor/presentation/widgets/tabbed_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/extensions.dart';

class ViewDocumentView extends StatelessWidget {
  final Document document;

  const ViewDocumentView(this.document, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CustomTabbedAppBar(
        showHomeScreenBar: false,
        screenTitle: document.documentName.toTitleCase,
        onBackPressed: Get.back,
        showTabBar: false,
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 1.0.wp),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 6.0.wp,
                  horizontal: 6.0.wp,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      FittedBox(
                        child: Text(
                          'Uploaded on : ${DateFormat('d MMM yyyy').format(document.addedDate)}',
                          style:
                              textTheme.bodyText2!.copyWith(fontSize: 10.0.sp),
                        ),
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
                        style: textTheme.bodyText2!.copyWith(fontSize: 10.0.sp),
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
                        document.documentType.toUpperCase(),
                        style: textTheme.bodyText2!.copyWith(fontSize: 10.0.sp),
                      ),
                    ]),
                    IconButton(
                      onPressed: () => Get.find<DocumentsController>()
                          .confirmDeletion(document.documentID, context),
                      icon: Icon(FontAwesome5.trash_alt, size: 5.0.wp),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.0.wp),
              Container(
                height: 60.0.hp,
                width: 100.0.wp,
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0.wp,
                  vertical: 5.0.wp,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Image.file(
                  File(document.documentPath),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
