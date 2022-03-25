import 'package:equatable/equatable.dart';

class Medication extends Equatable {
  final String medicationID;
  final String medicationName;
  final String drugClass;
  final String drugBrand;
  final String drugCode;
  final String drugType;
  final String drugStrength;

  final String form;
  final String adminRoute;
  final int dose;
  final List<String> doseHours;
  final int frequency;
  final String instructions;
  final String reason;

  const Medication({
    required this.medicationID,
    required this.medicationName,
    required this.drugClass,
    required this.drugBrand,
    required this.drugCode,
    required this.drugType,
    required this.drugStrength,
    required this.form,
    required this.adminRoute,
    required this.dose,
    required this.doseHours,
    required this.frequency,
    required this.instructions,
    required this.reason,
  });

  @override
  List<Object?> get props => [medicationName, drugClass, drugCode, drugType];
}
