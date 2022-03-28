import 'package:care_monitor/presentation/screens/documents/documents_controller.dart';
import 'package:care_monitor/presentation/screens/documents/widgets/document_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          TextButton(
            onPressed: documentsController.setCurrentPickedFile,
            child: Text('Add Document', style: textTheme.button),
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
}
