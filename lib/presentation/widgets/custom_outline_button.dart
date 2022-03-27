import 'package:care_monitor/core/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../core/utils/extensions.dart';

class CustomOutlineButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;
  final String buttonText;

  const CustomOutlineButton({
    Key? key,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: 4.0.wp,
          vertical: 4.0.wp,
        ),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.6),
          width: 1.2,
        ),
      ),
      child: Text(
        buttonText,
        style: textTheme.button!.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: 14.0.sp,
        ),
      ),
    );
  }
}
