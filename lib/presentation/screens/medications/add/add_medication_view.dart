import 'package:care_monitor/core/theme/colors.dart';
import 'package:care_monitor/presentation/screens/medications/add/add_medication_controller.dart';
import 'package:care_monitor/presentation/widgets/tabbed_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/extensions.dart';

class AddMedicationView extends StatelessWidget {
  final AddMedicationController addMedicationController =
      Get.find<AddMedicationController>();

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._buildInputWidgets(
                    textTheme: textTheme,
                    controller: addMedicationController.nameController,
                    title: 'Medication name',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                  ),
                  ..._buildInputWidgets(
                    textTheme: textTheme,
                    controller: addMedicationController.classController,
                    title: 'Drug Class',
                    bgColor: textBackgroundColor,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                  ),
                  ..._buildInputWidgets(
                    textTheme: textTheme,
                    controller: addMedicationController.brandController,
                    title: 'Drug Brand',
                    bgColor: textBackgroundColor,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                  ),
                  ..._buildInputWidgets(
                    textTheme: textTheme,
                    controller: addMedicationController.codeController,
                    title: 'Drug Code (GCN)',
                    bgColor: textBackgroundColor,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "This field is required";
                      } else if (!value.isNumericOnly) {
                        return "Only digits are accepted";
                      }

                      return null;
                    },
                  ),
                  _buildHorizontalInputs(
                    textTheme: textTheme,
                    firstTitle: 'Drug Type',
                    secondTitle: 'Strength',
                    firstController: addMedicationController.typeController,
                    secondController:
                        addMedicationController.strengthController,
                    bgColor: textBackgroundColor,
                  ),
                  _buildHorizontalInputs(
                    textTheme: textTheme,
                    firstTitle: 'Form',
                    secondTitle: 'Route of Administration',
                    firstController: addMedicationController.formController,
                    secondController: addMedicationController.routeController,
                    bgColor: textBackgroundColor,
                  ),
                  _buildHorizontalInputs(
                    textTheme: textTheme,
                    firstTitle: 'Dose',
                    secondTitle: '',
                    firstController: addMedicationController.doseController,
                    secondController: addMedicationController.routeController,
                  ),
                  _buildHorizontalInputs(
                    textTheme: textTheme,
                    firstTitle: 'Frequency',
                    secondTitle: '',
                    firstController: addMedicationController.formController,
                    secondController: addMedicationController.routeController,
                  ),
                  _buildHorizontalInputs(
                    textTheme: textTheme,
                    firstTitle: 'Dosing Hours (First Dose)',
                    secondTitle: '',
                    firstController: addMedicationController.formController,
                    secondController: addMedicationController.routeController,
                  ),
                  ..._buildInputWidgets(
                    textTheme: textTheme,
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
                  ..._buildInputWidgets(
                    textTheme: textTheme,
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
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              primaryDarkColor),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(
                              horizontal: 6.0.wp,
                              vertical: 4.0.wp,
                            ),
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
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(
                              horizontal: 4.0.wp,
                              vertical: 4.0.wp,
                            ),
                          ),
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(
                              color: Colors.grey.withOpacity(0.6),
                              width: 1.2,
                            ),
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

  Widget _buildHorizontalInputs({
    required TextTheme textTheme,
    required String firstTitle,
    required String secondTitle,
    required TextEditingController firstController,
    required TextEditingController secondController,
    Color bgColor = Colors.white,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildInputWidgets(
              textTheme: textTheme,
              controller: addMedicationController.typeController,
              title: firstTitle,
              bgColor: bgColor,
              validator: (value) {
                return null;
              },
            ),
          ),
        ),
        SizedBox(width: 4.0.wp),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildInputWidgets(
              textTheme: textTheme,
              controller: addMedicationController.typeController,
              title: secondTitle,
              bgColor: bgColor,
              validator: (value) {
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildInputWidgets({
    required TextTheme textTheme,
    required TextEditingController controller,
    required String title,
    required Function(String?) validator,
    Color bgColor = Colors.white,
    TextCapitalization capitalization = TextCapitalization.words,
  }) {
    return [
      Text(title, style: textTheme.subtitle2, softWrap: false),
      SizedBox(height: 2.0.wp),
      TextFormField(
        controller: controller,
        style: textTheme.headline5,
        textCapitalization: capitalization,
        decoration: InputDecoration(
          filled: true,
          fillColor: bgColor,
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
    ];
  }

  void _onSave() {
    if (addMedicationController.formKey.currentState!.validate()) {
      // add medication to database
      addMedicationController.addMedication();
    }
  }
}
