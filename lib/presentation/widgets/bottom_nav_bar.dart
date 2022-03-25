import 'package:care_monitor/core/theme/colors.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {

  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite, color: primaryColor),
          label: 'Health',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_rounded, color: primaryColor),
          label: 'Calender',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add, color: primaryColor),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: primaryColor),
          label: 'Team',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble, color: primaryColor),
          label: 'Chat',
        ),
      ],
    );
  }
}
