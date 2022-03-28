import 'package:care_monitor/domain/usecases/document/delete_document.dart';
import 'package:care_monitor/domain/usecases/document/fetch_documents.dart';
import 'package:care_monitor/domain/usecases/document/save_document.dart';
import 'package:care_monitor/presentation/screens/documents/documents_controller.dart';
import 'package:care_monitor/presentation/screens/documents/view.dart';
import 'package:care_monitor/presentation/screens/medications/view.dart';
import 'package:care_monitor/presentation/widgets/bottom_nav_bar.dart';
import 'package:care_monitor/presentation/widgets/tabbed_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<dynamic> _initDependencies() {
  return [
    Get.find<SaveDocument>(),
    Get.find<DeleteDocument>(),
    Get.find<FetchDocuments>()
  ];
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: const CustomTabbedAppBar(showHomeScreenBar: true),
        bottomNavigationBar: const BottomNavBar(),
        body: TabBarView(
          children: [
            const Center(child: Text('Activities')),
            MedicationsTab(),
            const Center(child: Text('Resources')),
            GetBuilder<DocumentsController>(
              init: DocumentsController(
                saveDocument: _initDependencies().first,
                deleteDocument: _initDependencies()[1],
                fetchDocuments: _initDependencies().last,
              ),
              builder: (controller) => DocumentsTab(),
            ),
            const Center(child: Text('Profile')),
          ],
        ),
      ),
    );
  }
}
