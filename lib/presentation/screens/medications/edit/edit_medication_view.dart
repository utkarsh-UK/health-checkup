import 'package:care_monitor/core/theme/colors.dart';
import 'package:care_monitor/core/utils/helpers.dart';
import 'package:care_monitor/presentation/screens/medications/medication_controller.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/dose_dropdown_inputs.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/dropdown_fields.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/horizontal_text_fields.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/txt_input_dropdown.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/txt_input_field.dart';
import 'package:care_monitor/presentation/widgets/custom_outline_button.dart';
import 'package:care_monitor/presentation/widgets/tabbed_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/extensions.dart';

class EditMedicationView extends StatelessWidget {
  final MedicationController addMedicationController =
      Get.find<MedicationController>();

  EditMedicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // print(addMedicationController.medication.value!.frequency);

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
              child: Obx(
                () => addMedicationController.medication.value == null
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
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
                            leftInputController:
                                addMedicationController.typeController,
                            rightInputController:
                                addMedicationController.strengthController,
                            backgroundColor: textBackgroundColor,
                          ),
                          HorizontalTextFields(
                            leftTitle: 'Form',
                            rightTitle: 'Route of Administration',
                            leftInputController:
                                addMedicationController.formController,
                            rightInputController:
                                addMedicationController.routeController,
                            backgroundColor: textBackgroundColor,
                          ),
                          TxtInputWithDropdown(
                            title: 'Dose',
                            doseType: 'dose_type',
                            controller: addMedicationController.doseController,
                            inputType: TextInputType.number,
                            // selectedDropdownOption: addMedicationController.doseController.text,
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
                            selectedSecondDropdownOption:
                                addMedicationController
                                    .medication.value!.frequencyPeriod,
                            selectedFirstDropdownOption: Helpers.getFrequency(
                              addMedicationController
                                  .medication.value!.frequency,
                            ).toUpperCase(),
                            onLeftDropChanged: (period) {
                              final int freq = Helpers.fromFrequency(period!);
                              addMedicationController.setNoOfDoses(freq);
                            },
                            onRightDropChanged: (period) {
                              addMedicationController
                                  .setFrequencyPeriod(period!);
                            },
                          ),
                          Column(children: _getExtraDosesDropDown(textTheme)),
                          TxtInputField(
                            controller:
                                addMedicationController.intructionsController,
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
                            controller:
                                addMedicationController.reasonController,
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
                              CustomOutlineButton(
                                textColor: Colors.white,
                                backgroundColor: primaryColor,
                                buttonText: 'Save',
                                onTap: _onSave,
                              ),
                              SizedBox(width: 6.0.wp),
                              CustomOutlineButton(
                                backgroundColor: Colors.white,
                                textColor: primaryColor,
                                buttonText: 'Cancel',
                                onTap: () {
                                  addMedicationController.clearControllers();
                                  Get.back();
                                },
                              ),
                            ],
                          )
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getExtraDosesDropDown(TextTheme textTheme) {
    const OrdinalNumber = Helpers.getOrdinalNumbers;

    return List<int>.generate(addMedicationController.noOfDoses.value, (_) => _)
        .map(
          (i) => DoseDropdownInput(
            title: 'Dosing Hours (${OrdinalNumber(i)} Dose)',
            doseType: 'dose_time',
            isDoseHoursSelector: false,
            selectedDropdownOption:
                addMedicationController.medication.value!.doseHours[i],
            onChanged: (value) {
              addMedicationController.addDoseHours(i, value!);
            },
            onSaved: (value) {
              addMedicationController.addDoseHours(i, value!);
            },
            index: i,
            isAMSelected:
                addMedicationController.medication.value!.doseMeridians[i] ==
                    'AM',
          ),
        )
        .toList();
  }

  void _onSave() {
    if (addMedicationController.formKey.currentState!.validate()) {
      // update medication to database
      addMedicationController.updateMedication();
    }
  }
}
