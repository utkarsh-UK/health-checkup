import 'package:care_monitor/core/theme/colors.dart';
import 'package:care_monitor/core/utils/helpers.dart';
import 'package:care_monitor/presentation/screens/medications/add/add_medication_controller.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/dose_dropdown_inputs.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/dropdown_fields.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/horizontal_text_fields.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/txt_input_dropdown.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/txt_input_field.dart';
import 'package:care_monitor/presentation/widgets/tabbed_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/extensions.dart';

class EditMedicationView extends StatelessWidget {
  final AddMedicationController addMedicationController =
      Get.find<AddMedicationController>();

  EditMedicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CustomTabbedAppBar(
        showHomeScreenBar: false,
        screenTitle: 'Edit New Medication',
        onBackPressed: Get.back,
        showTabBar: false,
      ),
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.0.wp, horizontal: 6.0.wp),
            child: Form(
              key: addMedicationController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TxtInputField(
                    controller: addMedicationController.nameController,
                    title: 'Medication name',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                  ),
                  TxtInputField(
                    controller: addMedicationController.classController,
                    title: 'Drug Class',
                    backgroundColor: textBackgroundColor,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                  ),
                  TxtInputField(
                    controller: addMedicationController.brandController,
                    title: 'Drug Brand',
                    backgroundColor: textBackgroundColor,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                  ),
                  TxtInputField(
                    controller: addMedicationController.codeController,
                    title: 'Drug Code (GCN)',
                    backgroundColor: textBackgroundColor,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "This field is required";
                      } else if (!value.isNumericOnly) {
                        return "Only digits are accepted";
                      }

                      return null;
                    },
                  ),
                  HorizontalTextFields(
                    leftTitle: 'Drug Type',
                    rightTitle: 'Strength',
                    leftInputController: addMedicationController.typeController,
                    rightInputController:
                        addMedicationController.strengthController,
                    backgroundColor: textBackgroundColor,
                  ),
                  HorizontalTextFields(
                    leftTitle: 'Form',
                    rightTitle: 'Route of Administration',
                    leftInputController: addMedicationController.formController,
                    rightInputController:
                        addMedicationController.routeController,
                    backgroundColor: textBackgroundColor,
                  ),
                  TxtInputWithDropdown(
                    title: 'Dose',
                    doseType: 'dose_type',
                    controller: addMedicationController.doseController,
                    inputType: TextInputType.number,
                    onChanged: (dose) {
                      addMedicationController.setDoseType(dose!);
                    },
                    onSaved: (dose) {
                      addMedicationController.setDoseType(dose!);
                    },
                  ),
                  DropdownFields(
                    title: 'Frequency',
                    leftDoseType: 'frequency',
                    rightDoseType: 'frequency_day',
                    isDoseHoursSelector: true,
                    onLeftDropSaved: (period) {},
                    onRightDropSaved: (period) {
                      addMedicationController.setFrequencyPeriod(period!);
                    },
                  ),
                  DoseDropdownInput(
                    title: 'Dosing Hours (First Dose)',
                    doseType: 'dose_time',
                    onChanged: (value) {
                      addMedicationController.addDoseHours(0, value!);
                    },
                    onSaved: (value) {
                      addMedicationController.addDoseHours(0, value!);
                    },
                    index: 1,
                  ),
                  Obx(() => addMedicationController.noOfDoses > 1
                      ? Column(children: _getExtraDosesDropDown(textTheme))
                      : const SizedBox.shrink()),
                  TxtInputField(
                    controller: addMedicationController.intructionsController,
                    title: 'Instructions',
                    capitalization: TextCapitalization.sentences,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "This field is required";
                      }

                      return null;
                    },
                  ),
                  TxtInputField(
                    controller: addMedicationController.reasonController,
                    title: 'Reason for Prescription:',
                    capitalization: TextCapitalization.sentences,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "This field is required";
                      }

                      return null;
                    },
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: _onSave,
                        style: TextButton.styleFrom(
                          backgroundColor: primaryDarkColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.0.wp,
                            vertical: 4.0.wp,
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: textTheme.button!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.0.wp),
                      TextButton(
                        onPressed: () {
                          addMedicationController.clearControllers();
                          Get.back();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
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
                          'Cancel',
                          style: textTheme.button!.copyWith(
                            color: primaryTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0.sp,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getExtraDosesDropDown(TextTheme textTheme) {
    const OrdinalNumber = Helpers.getOrdinalNumbers;

    return List<int>.generate(
            addMedicationController.noOfDoses.value - 1, (_) => _)
        .map(
          (i) => DoseDropdownInput(
            title: 'Dosing Hours (${OrdinalNumber(i + 1)} Dose)',
            doseType: 'dose_time',
            isDoseHoursSelector: false,
            onChanged: (value) {
              addMedicationController.addDoseHours(i + 1, value!);
            },
            onSaved: (value) {
              addMedicationController.addDoseHours(i + 1, value!);
            },
            index: i + 2,
          ),
        )
        .toList();
  }

  void _onSave() {
    if (addMedicationController.formKey.currentState!.validate()) {
      // add medication to database
      addMedicationController.addMedication();
    }
  }
}
