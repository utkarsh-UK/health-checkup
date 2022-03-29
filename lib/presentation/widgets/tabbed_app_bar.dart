import 'package:care_monitor/core/theme/colors.dart';
import 'package:care_monitor/presentation/screens/medications/medication_binding.dart';
import 'package:care_monitor/presentation/screens/medications/add/add_medication_view.dart';
import 'package:care_monitor/presentation/screens/medications/search/search_medication_view.dart';
import 'package:care_monitor/presentation/widgets/dialog_animation.dart';
import 'package:care_monitor/presentation/widgets/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../core/utils/extensions.dart';

/// Builds custom app bar for application
///
/// If [showHomeScreenBar] is true, widget will display actions. Else, [screenTitle] and
/// back button with [onBackPressed] will be rendered.
class CustomTabbedAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool showHomeScreenBar;
  final bool showTabBar;
  final String? screenTitle;
  final VoidCallback? onBackPressed;

  const CustomTabbedAppBar({
    Key? key,
    required this.showHomeScreenBar,
    this.showTabBar = true,
    this.screenTitle,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      toolbarHeight: showTabBar ? 50.0.wp : 20.0.wp,
      elevation: 0.0,
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 3.0.wp),
        child: Text(screenTitle ?? 'My Health', style: textTheme.headline3),
      ),
      leading: showHomeScreenBar
          ? null
          : IconButton(
              onPressed: onBackPressed,
              icon: Container(
                padding: EdgeInsets.all(2.0.wp),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: const Offset(0, 2),
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: iconColor,
                ),
              ),
            ),
      actions: !showHomeScreenBar
          ? null
          : [
              TextButton.icon(
                onPressed: () => Get.to(
                  () => SearchMedicationView(),
                  binding: MedicationBinding(),
                ),
                label: Container(
                  padding: EdgeInsets.all(2.0.wp),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                  ),
                  child: const Icon(Icons.add, size: 25.0, color: Colors.white),
                ),
                icon: Text('Add New', style: textTheme.button),
              ),
            ],
      bottom: !showTabBar
          ? null
          : TabBar(
              labelColor: primaryColor,
              labelStyle: textTheme.headline5,
              unselectedLabelColor: secondaryTextColor,
              padding: EdgeInsets.only(top: 4.0.wp),
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(horizontal: 4.0.wp),
              tabs: const [
                Tab(text: 'Activities'),
                Tab(text: 'Medications'),
                Tab(text: 'Resources'),
                Tab(text: 'Documents'),
                Tab(text: 'Profile'),
              ],
            ),
    );
  }

  @override
  Size get preferredSize => Size(100, showTabBar ? 35.0.wp : 20.0.wp);
}
