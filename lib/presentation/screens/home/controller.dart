import 'package:care_monitor/core/theme/colors.dart';
import 'package:care_monitor/core/usecases/usecase.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:care_monitor/domain/entities/medication.dart';
import 'package:care_monitor/domain/usecases/medication/add_medication.dart';
import 'package:care_monitor/domain/usecases/medication/delete_medication.dart';
import 'package:care_monitor/domain/usecases/medication/edit_medication.dart';
import 'package:care_monitor/domain/usecases/medication/fetch_medications.dart';
import 'package:care_monitor/domain/usecases/medication/search_medication.dart';
import 'package:care_monitor/presentation/widgets/dialog_animation.dart';
import 'package:care_monitor/presentation/widgets/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AddMedication _addMedication;
  final EditMedication _editMedication;
  final DeleteMedication _deleteMedication;
  final SearchMedication _searchMedication;
  final FetchMedication _fetchMedication;

  HomeController({
    required AddMedication addMedication,
    required EditMedication editMedication,
    required DeleteMedication deleteMedication,
    required SearchMedication searchMedication,
    required FetchMedication fetchMedication,
  })  : _addMedication = addMedication,
        _editMedication = editMedication,
        _deleteMedication = deleteMedication,
        _searchMedication = searchMedication,
        _fetchMedication = fetchMedication;

  final categorizedMedications = <String, List<Medication>>{}.obs;
  final medications = <Medication>[].obs;
  final errorMessage = "".obs;
  final isMedAdded = false.obs;

  @override
  void onInit() {
    super.onInit();

    getMedications();
    ever(medications, (list) {
      categorizedMedications.value = <String, List<Medication>>{
        'DAILY':
            medications.where((med) => med.frequencyPeriod == 'Day').toList(),
        'WEEKLY':
            medications.where((med) => med.frequencyPeriod == 'Week').toList(),
        'MONTHLY':
            medications.where((med) => med.frequencyPeriod == 'Month').toList(),
      };
    });
  }

  void getMedications() async {
    final failureOrList = await _fetchMedication(NoParams());

    // Unfold the Either object to extract Failure or result.
    failureOrList.fold(
      (Failure fail) {
        if (fail is ServerFailure) {
          errorMessage.value = fail.message;
        }
      },
      (medList) {
        medications.assignAll(medList);
      },
    );
  }

  void addMedication(Medication med, BuildContext context) async {
    final failureOrList = await _addMedication(
      Params(medication: med),
    );

    // Unfold the Either object to extract Failure or result.
    failureOrList.fold(
      (Failure fail) {
        if (fail is ServerFailure) {
          errorMessage.value = fail.message;
          isMedAdded.value = false;
          showDialog(
            context: context,
            title: 'Failed',
            message: 'Adding medication failed. Please try again later.',
            displayIcon: Icons.close,
          );
        }
      },
      (_) {
        isMedAdded.value = true;
        showDialog(
          context: context,
          title: 'Success',
          message: 'You have successfully added the medication.',
          displayIconColor: checkIconColor,
          shouldShowActions: false,
        );
        getMedications();
      },
    );
  }

  void updateMedication(
      String medicationId, Medication med, BuildContext context) async {
    final failureOrList = await _editMedication(
        Params(medicineID: medicationId, medication: med));

    // Unfold the Either object to extract Failure or result.
    failureOrList.fold(
      (Failure fail) {
        if (fail is ServerFailure) {
          errorMessage.value = fail.message;
          isMedAdded.value = false;
          showDialog(
            context: context,
            title: 'Failed',
            message: 'Updating medication failed. Please try again later.',
            displayIcon: Icons.close,
          );
        }
      },
      (_) {
        showDialog(
          context: context,
          title: 'Success',
          message: 'You have successfully edited the medication.',
          displayIconColor: checkIconColor,
          shouldShowActions: false,
        );
        getMedications();
      },
    );
  }

  Future<List<String>> searchMedication(String medicationName) async {
    List<String> _meds = [];

    final failureOrList =
        await _searchMedication(Params(medicationName: medicationName));

    // Unfold the Either object to extract Failure or result.
    failureOrList.fold(
      (Failure fail) {
        if (fail is ServerFailure) {
          errorMessage.value = fail.message;
          isMedAdded.value = false;
          Get.snackbar('Error', 'Medication searching failed!');
        }
      },
      (list) {
        // Get.snackbar('Success', 'You have successfully updated the medication');
        _meds = list..sort(((a, b) => a.compareTo(b)));
      },
    );

    return _meds;
  }

  void confirmDeletion(String medicationID, BuildContext context) async {
    showDialog(
      context: context,
      title: 'Delete Medication',
      message: 'Do you want to delete this medication?',
      shouldShowActions: true,
      primaryBtnText: 'Delete',
      secondaryBtnText: 'Cancel',
      displayIcon: Icons.delete_outline_outlined,
      onPrimaryBtnClick: () {
        Get.back();
        deleteMedication(medicationID, context);
      },
    );
  }

  void deleteMedication(String medicationId, BuildContext context) async {
    final failureOrList =
        await _deleteMedication(Params(medicineID: medicationId));

    // Unfold the Either object to extract Failure or result.
    failureOrList.fold(
      (Failure fail) {
        if (fail is ServerFailure) {
          errorMessage.value = fail.message;
          showDialog(
            context: context,
            title: 'Failed',
            message: 'Deletion failed. Please try again later.',
            displayIcon: Icons.close,
          );
        }
      },
      (_) {
        showDialog(
          context: context,
          title: 'Success',
          message: 'You have successfully deleted the medication.',
          displayIconColor: checkIconColor,
          shouldShowActions: false,
        );
        getMedications();
      },
    );
  }

  Future<T?> showDialog<T>({
    required BuildContext context,
    required String title,
    required String message,
    String? primaryBtnText,
    String? secondaryBtnText,
    IconData displayIcon = Icons.check,
    Color displayIconColor = Colors.white,
    bool shouldShowActions = false,
    VoidCallback? onPrimaryBtnClick,
  }) {
    return showGeneralDialog(
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      barrierDismissible: true,
      barrierLabel: 'label',
      pageBuilder: (ctx, anim1, anim2) => MessageDialog(
        title: title,
        message: message,
        shouldShowActions: shouldShowActions,
        displayIconColor: displayIconColor,
        displayIcon: displayIcon,
        primaryBtnText: primaryBtnText,
        secondaryBtnText: secondaryBtnText,
        onPrimaryButtonClick: onPrimaryBtnClick,
      ),
      transitionBuilder: (context, anim1, anim2, child) =>
          DialogAnimation(animationValue: anim1, child: child),
    );
  }
}
