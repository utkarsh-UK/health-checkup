import 'package:care_monitor/core/theme/colors.dart';
import 'package:care_monitor/presentation/widgets/custom_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/extensions.dart';

class MessageDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? primaryBtnText;
  final String? secondaryBtnText;
  final IconData displayIcon;
  final VoidCallback? onPrimaryButtonClick;
  final Color displayIconColor;
  final bool shouldShowActions;

  const MessageDialog({
    Key? key,
    required this.title,
    required this.message,
    this.primaryBtnText,
    this.secondaryBtnText,
    this.onPrimaryButtonClick,
    this.shouldShowActions = false,
    this.displayIcon = Icons.check,
    this.displayIconColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SimpleDialog(
      backgroundColor: Colors.white,
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -15.0.wp,
              left: 27.0.wp,
              child: Container(
                padding: EdgeInsets.all(4.0.wp),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconColor,
                ),
                child:
                    Icon(displayIcon, size: 15.0.wp, color: displayIconColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4.0.wp,
                vertical: 6.0.wp,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: Get.back,
                      icon: const Icon(Icons.close, size: 25.0),
                    ),
                  ),
                  Text(title, style: textTheme.headline4),
                  SizedBox(height: 6.0.wp),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: Text(
                      message,
                      style: textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 6.0.wp),
                  if (shouldShowActions)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomOutlineButton(
                            textColor: Colors.white,
                            backgroundColor: primaryColor,
                            buttonText: primaryBtnText ?? 'Delete',
                            onTap: onPrimaryButtonClick,
                          ),
                          SizedBox(width: 6.0.wp),
                          CustomOutlineButton(
                            backgroundColor: Colors.white,
                            textColor: primaryColor,
                            buttonText: secondaryBtnText ?? 'Cancel',
                            onTap: Get.back,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
