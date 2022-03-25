import 'package:care_monitor/core/theme/theme.dart';
import 'package:care_monitor/presentation/screens/home/view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CareMonitor',
      debugShowCheckedModeBanner: false,
      theme: ApplicationTheme.getAppThemeData(),
      home: const HomeScreen(),
    );
  }
}