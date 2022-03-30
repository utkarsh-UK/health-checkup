import 'package:care_monitor/presentation/screens/medications/widgets/dropdown_item.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/extensions.dart';

class DropdownFields extends StatelessWidget {
  final String title;
  final String leftDoseType;
  final String rightDoseType;
  final String? selectedFirstDropdownOption;
  final String? selectedSecondDropdownOption;
  final bool isFirstDoseHoursSelector;
  final bool isSecondDoseHoursSelector;
  final Function(String?) onLeftDropChanged;
  final Function(String?) onRightDropChanged;

  const DropdownFields({
    Key? key,
    required this.title,
    required this.leftDoseType,
    required this.rightDoseType,
    required this.onLeftDropChanged,
    required this.onRightDropChanged,
    this.selectedFirstDropdownOption,
    this.selectedSecondDropdownOption,
    this.isFirstDoseHoursSelector = false,
    this.isSecondDoseHoursSelector = false,
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
                isDoseHoursSelector: isFirstDoseHoursSelector,
                onDropdownChanged: onLeftDropChanged,
                selectedOption: selectedFirstDropdownOption,
                onSaved: (value) {},
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
                onSaved: (value) {},
                isDoseHoursSelector: isSecondDoseHoursSelector,
                onDropdownChanged: onRightDropChanged,
                selectedOption: selectedSecondDropdownOption,
              )
            ],
          ),
        ),
      ],
    );
  }
}
