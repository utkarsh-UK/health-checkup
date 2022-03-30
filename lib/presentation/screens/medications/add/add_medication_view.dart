import 'package:care_monitor/presentation/widgets/custom_outline_button.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/utils/helpers.dart';
import '../medication_controller.dart';
import '../widgets/dose_dropdown_inputs.dart';
import '../widgets/dropdown_fields.dart';
import '../widgets/horizontal_text_fields.dart';
import '../widgets/txt_input_dropdown.dart';
import '../widgets/txt_input_field.dart';
import '../../../widgets/tabbed_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/extensions.dart';

typedef OrdinalNumber = Function(int count);

class AddMedicationView extends StatelessWidget {
  final MedicationController addMedicationController =
      Get.find<MedicationController>();

  AddMedicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CustomTabbedAppBar(
        showHomeScreenBar: false,
        screenTitle: 'Add New Medication',
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
              child: AnimationLimiter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 400),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 70.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
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
                        isFirstDoseHoursSelector: true,
                        onLeftDropChanged: (dose) {
                          final int freq = Helpers.fromFrequency(dose!);
                          addMedicationController.setNoOfDoses(freq);
                        },
                        onRightDropChanged: (period) {
                          addMedicationController.setFrequencyPeriod(period!);
                        },
                      ),
                      Obx(
                        () => Column(
                          children: _getExtraDosesDropDown(
                            textTheme,
                            addMedicationController.noOfDoses.value,
                          ),
                        ),
                      ),
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
                          CustomOutlineButton(
                            textColor: Colors.white,
                            backgroundColor: primaryColor,
                            buttonText: 'Save',
                            onTap: () => _onSave(context),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getExtraDosesDropDown(TextTheme textTheme, int count) {
    const OrdinalNumber = Helpers.getOrdinalNumbers;

    return List<int>.generate(count, (_) => _)
        .map(
          (i) => DoseDropdownInput(
            title: 'Dosing Hours (${OrdinalNumber(i)} Dose)',
            doseType: 'dose_time',
            isDoseHoursSelector: false,
            onChanged: (value) {
              addMedicationController.addDoseHours(i, value!);
            },
            onSaved: (value) {
              addMedicationController.addDoseHours(i, value!);
            },
            index: i,
          ),
        )
        .toList();
  }

  void _onSave(BuildContext context) {
    if (addMedicationController.formKey.currentState!.validate()) {
      // add medication to database
      addMedicationController.addMedication(context);
    }
  }
}
