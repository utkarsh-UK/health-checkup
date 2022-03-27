import 'package:care_monitor/presentation/screens/medications/widgets/dropdown_item.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/txt_input_field.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/extensions.dart';

class TxtInputWithDropdown extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String doseType;
  final bool isDoseHoursSelector;
  final Color backgroundColor;
  final Function(String?) onChanged;
  final Function(String?) onSaved;
  final TextInputType inputType;

  const TxtInputWithDropdown({
    Key? key,
    required this.controller,
    required this.title,
    required this.doseType,
    required this.onChanged,
    required this.onSaved,
    this.isDoseHoursSelector = false,
    this.backgroundColor = Colors.white,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TxtInputField(
            controller: controller,
            title: title,
            backgroundColor: backgroundColor,
            validator: (value) {
              return null;
            },
            inputType: inputType,
          ),
        ),
        SizedBox(width: 4.0.wp),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3.0.wp),
              DropdownItem(
                dropDownMenuType: doseType,
                onDropdownChanged: onChanged,
                isDoseHoursSelector: isDoseHoursSelector,
                onSaved: onSaved,
              )
            ],
          ),
        ),
      ],
    );
  }
}
