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
      unselectedItemColor: Colors.grey.withOpacity(0.8),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: _currentSelectedIndex,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
        height: 1.5,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        height: 1.5,
      ),
      selectedFontSize: 14.0,
      unselectedFontSize: 14.0,
      selectedIconTheme: const IconThemeData(size: iconSize),
      unselectedIconTheme: const IconThemeData(size: iconSize),
      type: BottomNavigationBarType.fixed,
      onTap: (int i) => setState(() => _currentSelectedIndex = i),
      items: [
        const BottomNavigationBarItem(
          icon: Icon(FontAwesome.heartbeat, size: iconSize),
          label: 'Health',
        ),
        const BottomNavigationBarItem(
          icon: Icon(FontAwesome.calendar, size: iconSize),
          label: 'Calender',
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor,
            ),
            child: const Icon(
              Icons.add,
              size: iconSize,
              color: Colors.white,
            ),
          ),
          label: 'Activity',
        ),
        const BottomNavigationBarItem(
          icon: Icon(FontAwesome.user, size: iconSize),
          label: 'Team',
        ),
        const BottomNavigationBarItem(
          icon: Icon(FontAwesome.comment, size: iconSize),
          label: 'Chat',
        ),
      ],
    );
  }
}
