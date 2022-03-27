import 'package:equatable/equatable.dart';

class Medication extends Equatable {
  final String medicationID;
  final String medicationName;
  final String drugClass;
  final String drugBrand;
  final String drugCode;
  final String drugType;
  final String drugStrength;
  final String imagePath;

  final String form;
  final String adminRoute;
  final int dose;
  final List<String> doseHours;
  final List<String> doseMeridians;
  final int frequency;
  final String frequencyPeriod;
  final String instructions;
  final String reason;

  final DateTime dateAdded;
  final DateTime dateUpdated;

  const Medication({
    required this.medicationID,
    required this.medicationName,
    required this.drugClass,
    required this.drugBrand,
    required this.drugCode,
    required this.drugType,
    required this.drugStrength,
    required this.imagePath,
    required this.form,
    required this.adminRoute,
    required this.dose,
    required this.doseHours,
    required this.doseMeridians,
    required this.frequency,
    required this.frequencyPeriod,
    required this.instructions,
    required this.reason,
    required this.dateAdded,
    required this.dateUpdated,
  });

  @override
  List<Object?> get props => [medicationName, drugClass, drugCode, drugType];
}
