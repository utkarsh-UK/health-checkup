import 'package:care_monitor/core/theme/colors.dart';
import 'package:care_monitor/core/utils/helpers.dart';
import 'package:care_monitor/domain/entities/medication.dart';
import 'package:care_monitor/presentation/screens/home/controller.dart';
import 'package:care_monitor/presentation/screens/medications/medication_binding.dart';
import 'package:care_monitor/presentation/screens/medications/medication_controller.dart';
import 'package:care_monitor/presentation/screens/medications/edit/edit_medication_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/utils/extensions.dart';

class ExpandableMedItem extends StatefulWidget {
  final Medication medication;
  final Function(bool) onExpandedChanged;

  const ExpandableMedItem(
    this.medication, {
    Key? key,
    required this.onExpandedChanged,
  }) : super(key: key);

  @override
  _ExpandableMedItemState createState() => _ExpandableMedItemState();
}

class _ExpandableMedItemState extends State<ExpandableMedItem> {
  late Medication medication;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    medication = widget.medication;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ExpansionTile(
      onExpansionChanged: (value) {
        setState(() => isExpanded = value);
        widget.onExpandedChanged(value);
      },
      leading: Container(
        padding: EdgeInsets.symmetric(
          vertical: 2.0.wp,
          horizontal: 1.0.wp,
        ),
        height: 20.0.wp,
        width: 20.0.wp,
        child: Image.asset(medication.imagePath, fit: BoxFit.cover),
      ),
      title: Padding(
        padding: EdgeInsets.only(bottom: 2.0.wp),
        child: Text(
          medication.medicationName,
          style: textTheme.headline5,
        ),
      ),
      subtitle: Text(
        Helpers.getFrequency(
          medication.frequency,
        ).toUpperCase(),
        style: textTheme.headline6,
      ),
      children: _buildExpandedWidgets(medication, textTheme),
      childrenPadding: EdgeInsets.symmetric(vertical: 3.0.wp),
    );
  }

  List<Widget> _buildExpandedWidgets(Medication med, TextTheme textTheme) {
    return <Widget>[
      Divider(color: Colors.grey.withOpacity(0.7), thickness: 0.3.wp),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0.wp, vertical: 3.0.wp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._buildMedicineInfoText(
                            'Drug Class', med.drugClass, textTheme),
                        ..._buildMedicineInfoText(
                            'Drug Code', med.drugCode, textTheme),
                        ..._buildMedicineInfoText('Form', med.form, textTheme),
                        ..._buildMedicineInfoText(
                            'Strength', med.drugStrength, textTheme),
                        ..._buildMedicineInfoText(
                            'Dosing Hours',
                            '${med.doseHours.first} ${med.doseMeridians[0]}',
                            textTheme),
                        ..._buildMedicineInfoText(
                            'Date Added',
                            DateFormat('d MMM yyyy').format(med.dateAdded),
                            textTheme,
                            shouldAddBottomPadding: false),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.0.wp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._buildMedicineInfoText(
                            'Drug Brand', med.drugBrand, textTheme),
                        ..._buildMedicineInfoText(
                            'Drug Type', med.drugType, textTheme),
                        ..._buildMedicineInfoText('Route of Administration',
                            med.adminRoute, textTheme),
                        ..._buildMedicineInfoText(
                            'Dose: ', '${med.dose} Drops', textTheme),
                        ..._buildMedicineInfoText(
                            'Frequency',
                            '${Helpers.getFrequency(med.frequency).toTitleCase} a ${med.frequencyPeriod}',
                            textTheme),
                        ..._buildMedicineInfoText(
                            'Last Updated',
                            DateFormat('d MMM yyyy').format(med.dateUpdated),
                            textTheme,
                            shouldAddBottomPadding: false),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.0.wp),
            ..._buildMedicineInfoText(
              'Instructions:',
              med.instructions,
              textTheme,
              softWrap: true,
            ),
            ..._buildMedicineInfoText(
              'Reason for Prescription:',
              med.reason,
              textTheme,
              softWrap: true,
            ),
          ],
        ),
      ),
      Divider(color: Colors.grey.withOpacity(0.7), thickness: 0.3.wp),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
        child: Text(
          'Medication added by you',
          style: textTheme.headline6!.copyWith(
            color: bodyTextColor,
            fontWeight: FontWeight.w500,
            height: 1.4.sp,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: () {
                Get.to(
                  () => EditMedicationView(),
                  binding: MedicationBinding(),
                );

                Future.delayed(const Duration(milliseconds: 300), () {
                  final controller = Get.find<MedicationController>();
                  controller.setCurrentMedication(med);
                });
              },
              label: Container(
                height: 10.0.wp,
                padding: EdgeInsets.only(left: 4.0.wp),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 0.5.wp,
                    ),
                  ),
                ),
              ),
              icon: Text(
                'Edit',
                style: textTheme.button!.copyWith(
                  color: primaryColor,
                  fontSize: 14.0.sp,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final controller = Get.find<HomeController>();
                controller.confirmDeletion(med.medicationID);
              },
              child: Text(
                'Delete',
                style: textTheme.button!.copyWith(
                  color: primaryColor,
                  fontSize: 14.0.sp,
                ),
              ),
            ),
          ],
        ),
      )
    ];
  }

  List<Widget> _buildMedicineInfoText(
          String title, String data, TextTheme textTheme,
          {bool shouldAddBottomPadding = true, bool softWrap = false}) =>
      [
        RichText(
          softWrap: softWrap,
          text: TextSpan(
            children: [
              TextSpan(
                text: '$title\n',
                style: textTheme.headline6!.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  height: 1.4.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextSpan(
                text: data,
                style: textTheme.headline5,
              ),
            ],
          ),
        ),
        if (shouldAddBottomPadding) SizedBox(height: 1.5.wp),
      ];
}
