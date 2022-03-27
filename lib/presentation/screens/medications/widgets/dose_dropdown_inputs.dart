import 'package:care_monitor/presentation/screens/medications/add/add_medication_controller.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/dropdown_item.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/meridian_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/extensions.dart';

class DoseDropdownInput extends StatelessWidget {
  final String title;
  final String doseType;
  final bool isDoseHoursSelector;
  final Function(String?) onChanged;
  final Function(String?) onSaved;
  final int index;

  const DoseDropdownInput({
    Key? key,
    required this.title,
    required this.doseType,
    required this.onChanged,
    required this.onSaved,
    required this.index,
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
                dropDownMenuType: doseType,
                onDropdownChanged: onChanged,
                isDoseHoursSelector: isDoseHoursSelector,
                onSaved: onSaved,
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
              MeridianSelector(
                onTap: _setMeridian,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _setMeridian(String meridian) {
    switch (index) {
      case 1:
        Get.find<AddMedicationController>().setFirstMeridian(meridian);
        break;
      case 2:
        Get.find<AddMedicationController>().setSecondMeridian(meridian);
        break;
      case 3:
        Get.find<AddMedicationController>().setThirdMeridian(meridian);
        break;
      default:
        Get.find<AddMedicationController>().setFirstMeridian(meridian);
    }
  }
}
