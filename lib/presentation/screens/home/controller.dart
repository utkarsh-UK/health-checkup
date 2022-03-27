import 'package:care_monitor/core/usecases/usecase.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:care_monitor/domain/entities/medication.dart';
import 'package:care_monitor/domain/usecases/medication/add_medication.dart';
import 'package:care_monitor/domain/usecases/medication/delete_medication.dart';
import 'package:care_monitor/domain/usecases/medication/edit_medication.dart';
import 'package:care_monitor/domain/usecases/medication/fetch_medications.dart';
import 'package:care_monitor/domain/usecases/medication/search_medication.dart';
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

  void addMedication(Medication med) async {
    final failureOrList = await _addMedication(
      Params(medication: med),
    );

    // Unfold the Either object to extract Failure or result.
    failureOrList.fold(
      (Failure fail) {
        if (fail is ServerFailure) {
          errorMessage.value = fail.message;
          isMedAdded.value = false;
          Get.snackbar('Error', 'Medication adding failed!');
        }
      },
      (_) {
        isMedAdded.value = true;
        // Get.snackbar('Success', 'You have successfully added the medication');
        Get.defaultDialog(title: 'Success');
        getMedications();
      },
    );
  }

  void updateMedication(String medicationId, Medication med) async {
    final failureOrList = await _editMedication(
        Params(medicineID: medicationId, medication: med));

    // Unfold the Either object to extract Failure or result.
    failureOrList.fold(
      (Failure fail) {
        if (fail is ServerFailure) {
          errorMessage.value = fail.message;
          isMedAdded.value = false;
          Get.snackbar('Error', 'Medication updating failed!');
        }
      },
      (_) {
        // Get.snackbar('Success', 'You have successfully updated the medication');
        Get.defaultDialog(title: 'Success');
        getMedications();
      },
    );
  }

  void confirmDeletion(String medicationID) async {
    Get.defaultDialog(
      title: 'Success',
      backgroundColor: Colors.white,
      content: Text('Do you want to delete this medication'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            deleteMedication(medicationID);
          },
          child: Text('Delete'),
        ),
        TextButton(
          onPressed: Get.back,
          child: Text('Cancel'),
        )
      ],
    );
  }

  void deleteMedication(String medicationId) async {
    final failureOrList =
        await _deleteMedication(Params(medicineID: medicationId));

    // Unfold the Either object to extract Failure or result.
    failureOrList.fold(
      (Failure fail) {
        if (fail is ServerFailure) {
          errorMessage.value = fail.message;
          isMedAdded.value = false;
          Get.snackbar('Error', 'Medication deleting failed!');
        }
      },
      (_) {
        // Get.snackbar('Success', 'You have successfully deleted the medication');
        getMedications();
      },
    );
  }
}
