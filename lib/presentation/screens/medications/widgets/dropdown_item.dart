import 'package:care_monitor/core/utils/helpers.dart';
import 'package:care_monitor/presentation/screens/medications/medication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/extensions.dart';

final Map<String, List<String>> _dropDownMenus = {
  'dose_type': ['Capsules', 'Cream', 'Syrup'],
  'frequency': ['ONCE', 'TWICE', 'THRICE'],
  'frequency_day': ['Day', 'Week', 'Month'],
  'dose_time': [
    '00:00',
    '01:00',
    '02:00',
    '03:00',
    '04:00',
    '05:00',
    '06:00',
    '07:00',
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
  ],
};

class DropdownItem extends StatefulWidget {
  final String dropDownMenuType;
  final String? selectedOption;
  final bool isDoseHoursSelector;
  final Function(String?) onDropdownChanged;
  final Function(String?) onSaved;

  const DropdownItem({
    Key? key,
    required this.dropDownMenuType,
    this.selectedOption,
    required this.isDoseHoursSelector,
    required this.onDropdownChanged,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<DropdownItem> createState() => _DropdownItemState();
}

class _DropdownItemState extends State<DropdownItem> {
  late String dropDownMenuType;
  late Function(String?)? onDropdownChanged;

  late String selected;

  @override
  void initState() {
    super.initState();

    dropDownMenuType = widget.dropDownMenuType;
    onDropdownChanged = widget.onDropdownChanged;

    selected = widget.selectedOption ?? _dropDownMenus[dropDownMenuType]!.first;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DropdownButtonFormField<String>(
      value: selected,
      onChanged: (value) {
        if (widget.isDoseHoursSelector) {
          final int doseCount = Helpers.fromFrequency(value!);
          Get.find<MedicationController>().setNoOfDoses(doseCount);
        }

        setState(() => selected = value!);
        widget.onDropdownChanged(value);
      },
      onSaved: widget.onSaved,
      items: _dropDownMenus[widget.dropDownMenuType]!
          .map<DropdownMenuItem<String>>((item) => DropdownMenuItem(
                child: Text(item),
                value: item,
              ))
          .toList(),
      style: textTheme.headline5,
      icon: const Icon(Icons.keyboard_arrow_down_outlined, size: 25.0),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
        contentPadding:
            EdgeInsets.symmetric(vertical: 5.0.wp, horizontal: 3.0.wp),
        focusedBorder: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade300),
        ),
      ),
    );
  }
}
