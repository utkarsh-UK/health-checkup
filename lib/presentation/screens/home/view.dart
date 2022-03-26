import 'package:care_monitor/presentation/screens/medications/view.dart';
import 'package:care_monitor/presentation/widgets/bottom_nav_bar.dart';
import 'package:care_monitor/presentation/widgets/tabbed_app_bar.dart';
import 'package:flutter/material.dart';

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
            const Center(child: Text('Documents')),
            const Center(child: Text('Profile')),
          ],
        ),
      ),
    );
  }
}
