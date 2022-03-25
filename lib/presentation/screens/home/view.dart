import 'package:care_monitor/presentation/widgets/bottom_nav_bar.dart';
import 'package:care_monitor/presentation/widgets/tabbed_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: CustomTabbedAppBar(showHomeScreenBar: true),
        bottomNavigationBar: BottomNavBar(),
        body: TabBarView(children: [
          Center(child: Text('Activities')),
          Center(child: Text('Medications')),
          Center(child: Text('Resources')),
          Center(child: Text('Profile')),
        ]),
      ),
    );
  }
}
