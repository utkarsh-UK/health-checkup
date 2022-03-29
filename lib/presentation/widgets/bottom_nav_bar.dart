import 'package:care_monitor/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

const double iconSize = 30.0;

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey.withOpacity(0.7),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: _currentSelectedIndex,
      onTap: (int i) => setState(() => _currentSelectedIndex = i),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FontAwesome.heartbeat, size: iconSize),
          label: 'Health',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesome.calendar, size: iconSize),
          label: 'Calender',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesome.plus, size: iconSize),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesome.user, size: iconSize),
          label: 'Team',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesome.comment, size: iconSize),
          label: 'Chat',
        ),
      ],
    );
  }
}
