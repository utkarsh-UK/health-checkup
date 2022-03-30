import 'package:care_monitor/core/theme/colors.dart';
import 'package:care_monitor/presentation/screens/documents/documents_controller.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/txt_input_field.dart';
import 'package:care_monitor/presentation/widgets/bottom_nav_bar.dart';
import 'package:care_monitor/presentation/widgets/custom_outline_button.dart';
import 'package:care_monitor/presentation/widgets/tabbed_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';

import '../../../../core/utils/extensions.dart';

class AddDocumentView extends StatelessWidget {
  final DocumentsController documentsController =
      Get.find<DocumentsController>();

  AddDocumentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CustomTabbedAppBar(
        showHomeScreenBar: false,
        screenTitle: 'Add Document',
        onBackPressed: () {
          Get.back();
          documentsController.clearControllers();
        },
        showTabBar: false,
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: SingleChildScrollView(
          child: Form(
            key: documentsController.formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 6.0.wp,
                horizontal: 6.0.wp,
              ),
              child: Column(
                children: [
                  // document name input
                  TxtInputField(
                    controller: documentsController.nameController,
                    title: 'Document Name',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0.wp),
                  // document image with default name & size
                  Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 1.0.wp),
                            height: 25.0.wp,
                            width: 25.0.wp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0.wp),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2.0.wp),
                              child: (documentsController.currentDocument.value!
                                              .documentType
                                              .toLowerCase() ==
                                          'jpg' ||
                                      documentsController.currentDocument.value!
                                              .documentType
                                              .toLowerCase() ==
                                          'png')
                                  ? Image.file(
                                      documentsController
                                          .currentPickedFile.value!,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(FontAwesome5.file_pdf, size: 20.0.wp),
                            ),
                          ),
                          Positioned(
                            top: -10.0.wp,
                            right: -5,
                            child: InkWell(
                              onTap: Get.back,
                              child: Container(
                                padding: EdgeInsets.all(3.0.wp),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.9),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: 6.0.wp,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 5.0.wp),
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: documentsController.currentDocument.value!
                                            .documentName.length >
                                        15
                                    ? documentsController
                                        .currentDocument.value!.documentName
                                        .substring(0, 15)
                                    : documentsController
                                        .currentDocument.value!.documentName,
                                style: textTheme.headline6!.copyWith(
                                  fontSize: 16.0.sp,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '\n${documentsController.currentDocument.value!.documentSize}',
                                style: textTheme.bodyText2!
                                    .copyWith(fontSize: 14.0.sp, height: 1.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0.wp),
                  // action buttons
                  Row(
                    children: [
                      CustomOutlineButton(
                        textColor: Colors.white,
                        backgroundColor: primaryColor,
                        buttonText: 'Save',
                        onTap: () => _onSave(context),
                      ),
                      SizedBox(width: 6.0.wp),
                      CustomOutlineButton(
                        backgroundColor: Colors.white,
                        textColor: primaryColor,
                        buttonText: 'Cancel',
                        onTap: () {
                          documentsController.clearControllers();
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Saves current form and validates.
  ///
  /// If valid, proceed to save the document.
  void _onSave(BuildContext context) {
    if (documentsController.formKey.currentState!.validate()) {
      // add medication to database
      documentsController.saveDocument(context);
    }
  }
}
