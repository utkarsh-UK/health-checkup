import 'package:care_monitor/presentation/screens/medications/medication_controller.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/dropdown_item.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/meridian_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/extensions.dart';

class DoseDropdownInput extends StatelessWidget {
  final String title;
  final String doseType;
  final bool isDoseHoursSelector;
  final String? selectedDropdownOption;
  final Function(String?) onChanged;
  final Function(String?) onSaved;
  final int index;
  final bool isAMSelected;

  const DoseDropdownInput({
    Key? key,
    required this.title,
    required this.doseType,
    required this.onChanged,
    required this.onSaved,
    required this.index,
    this.selectedDropdownOption,
    this.isDoseHoursSelector = false,
    this.isAMSelected = true,
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
                dropDownMenuType: doseType,
                onDropdownChanged: onChanged,
                isDoseHoursSelector: isDoseHoursSelector,
                onSaved: onSaved,
                selectedOption: selectedDropdownOption,
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
              MeridianSelector(onTap: _setMeridian, isAMSelected: isAMSelected),
            ],
          ),
        ),
      ],
    );
  }

  void _setMeridian(String meridian) {
    switch (index) {
      case 0:
        Get.find<MedicationController>().setFirstMeridian(meridian);
        break;
      case 1:
        Get.find<MedicationController>().setSecondMeridian(meridian);
        break;
      case 2:
        Get.find<MedicationController>().setThirdMeridian(meridian);
        break;
      default:
        Get.find<MedicationController>().setFirstMeridian(meridian);
    }
  }
}
