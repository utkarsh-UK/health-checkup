import 'package:care_monitor/presentation/screens/medications/widgets/dropdown_item.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/extensions.dart';

class DropdownFields extends StatelessWidget {
  final String title;
  final String leftDoseType;
  final String rightDoseType;
  final bool isDoseHoursSelector;
  final Function(String?) onLeftDropSaved;
  final Function(String?) onRightDropSaved;

  const DropdownFields({
    Key? key,
    required this.title,
    required this.leftDoseType,
    required this.rightDoseType,
    required this.onLeftDropSaved,
    required this.onRightDropSaved,
    this.isDoseHoursSelector = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.subtitle2, softWrap: false),
              SizedBox(height: 2.0.wp),
              DropdownItem(
                dropDownMenuType: leftDoseType,
                onDropdownChanged: (value) {},
                isDoseHoursSelector: isDoseHoursSelector,
                onSaved: onLeftDropSaved,
              )
            ],
          ),
        ),
        SizedBox(width: 4.0.wp),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('', style: textTheme.subtitle2, softWrap: false),
              SizedBox(height: 3.0.wp),
              DropdownItem(
                dropDownMenuType: rightDoseType,
                onDropdownChanged: (value) {},
                isDoseHoursSelector: isDoseHoursSelector,
                onSaved: onRightDropSaved,
              )
            ],
          ),
        ),
      ],
    );
  }
}
