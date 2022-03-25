import 'package:care_monitor/core/theme/theme.dart';
import 'package:care_monitor/data/services/storage_service.dart';
import 'package:care_monitor/di/injection.dart';
import 'package:care_monitor/presentation/screens/home/binding.dart';
import 'package:care_monitor/presentation/screens/home/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  DependencyInjector().inject();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CareMonitor',
      debugShowCheckedModeBanner: false,
      theme: ApplicationTheme.getAppThemeData(),
      home: const HomeScreen(),
      initialBinding: HomeBinding(),
    );
  }
}
