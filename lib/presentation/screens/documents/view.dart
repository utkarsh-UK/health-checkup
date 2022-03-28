import 'package:care_monitor/core/theme/colors.dart';
import 'package:care_monitor/presentation/screens/documents/documents_controller.dart';
import 'package:care_monitor/presentation/screens/documents/widgets/document_item.dart';
import 'package:care_monitor/presentation/widgets/custom_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/extensions.dart';

const List<Map<String, dynamic>> bottomSheetMenus = [
  {
    'name': 'Camera',
    'icon': Icons.camera_alt,
  },
  {
    'name': 'Gallery',
    'icon': Icons.photo,
  },
  {
    'name': 'Document',
    'icon': Icons.assignment,
  },
];

class DocumentsTab extends StatelessWidget {
  final DocumentsController documentsController =
      Get.find<DocumentsController>();

  DocumentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton.icon(
            // onPressed: documentsController.setCurrentPickedFile,
            onPressed: () => _showDocumentTypeBottomSheet(context, textTheme),
            label: Text(
              'Add Document',
              style: textTheme.button!
                  .copyWith(color: primaryColor, fontSize: 14.0.sp),
            ),
            icon: Icon(Icons.add, color: primaryColor, size: 8.0.wp),
          ),
          Obx(
            () => documentsController.savedDocuments.isEmpty
                ? const Center(child: Text('Empty Documents'))
                : ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: documentsController.savedDocuments
                        .map<Widget>((doc) => DocumentItem(doc))
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }

  void _showDocumentTypeBottomSheet(BuildContext context, TextTheme textTheme) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
        child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black26.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4.0.wp),
              ),
              child: ListView.separated(
                itemCount: bottomSheetMenus.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => Divider(
                  color: Colors.grey.withOpacity(0.6),
                  thickness: 0.3.wp,
                ),
                itemBuilder: (ctx, index) => ListTile(
                  onTap: () {
                    Get.back();
                    documentsController
                        .setCurrentPickedFile(bottomSheetMenus[index]['name']);
                  },
                  leading: Icon(
                    bottomSheetMenus[index]['icon'],
                    size: 8.0.wp,
                    color: Colors.white,
                  ),
                  title: Text(
                    bottomSheetMenus[index]['name'],
                    style: textTheme.bodyText2!.copyWith(
                      color: Colors.white,
                      fontSize: 12.0.sp,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: Get.width,
              margin: EdgeInsets.only(top: 3.0.wp, bottom: 6.0.wp),
              child: CustomOutlineButton(
                onTap: Get.back,
                backgroundColor: Colors.white.withOpacity(0.7),
                textColor: primaryColor,
                buttonText: 'Cancel',
              ),
            )
          ],
        ),
      ),
    );
  }
}
