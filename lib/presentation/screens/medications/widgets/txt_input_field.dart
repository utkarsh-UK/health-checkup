import 'package:care_monitor/core/theme/colors.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/extensions.dart';

class TxtInputField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextCapitalization capitalization;
  final Function(String?) validator;
  final Color backgroundColor;
  final TextInputType inputType;

  const TxtInputField({
    Key? key,
    required this.title,
    required this.controller,
    this.capitalization = TextCapitalization.words,
    this.inputType = TextInputType.text,
    required this.validator,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.subtitle2, softWrap: false),
        SizedBox(height: 2.0.wp),
        TextFormField(
          controller: controller,
          style: textTheme.headline5,
          textCapitalization: capitalization,
          keyboardType: inputType,
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.0),
              borderSide: const BorderSide(width: 0.0, style: BorderStyle.none),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryTextColor.withOpacity(0.4),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade300),
            ),
          ),
          validator: (value) => validator(value),
        ),
        SizedBox(height: 4.0.wp),
      ],
    );
  }
}
