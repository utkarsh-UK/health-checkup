import 'package:care_monitor/presentation/screens/medications/widgets/txt_input_field.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/extensions.dart';

class HorizontalTextFields extends StatelessWidget {
  final TextEditingController leftInputController;
  final TextEditingController rightInputController;
  final String leftTitle;
  final String rightTitle;
  final Color backgroundColor;

  const HorizontalTextFields({
    Key? key,
    required this.leftInputController,
    required this.rightInputController,
    required this.leftTitle,
    required this.rightTitle,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TxtInputField(
            controller: leftInputController,
            title: leftTitle,
            backgroundColor: backgroundColor,
            validator: (value) {
              return null;
            },
          ),
        ),
        SizedBox(width: 4.0.wp),
        Expanded(
          child: TxtInputField(
            controller: rightInputController,
            title: rightTitle,
            backgroundColor: backgroundColor,
            validator: (value) {
              return null;
            },
          ),
        ),
      ],
    );
  }
}
