// ignore_for_file: annotate_overrides, overridden_fields

import 'package:care_monitor/domain/entities/medication.dart';

class MedicationModel extends Medication {
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

  final DateTime dateAdded;
  final DateTime dateUpdated;

  const MedicationModel({
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
    required this.dateAdded,
    required this.dateUpdated,
  }) : super(
          medicationID: medicationID,
          medicationName: medicationName,
          drugClass: drugClass,
          drugBrand: drugBrand,
          drugCode: drugCode,
          drugType: drugType,
          drugStrength: drugStrength,
          form: form,
          adminRoute: adminRoute,
          dose: dose,
          doseHours: doseHours,
          frequency: frequency,
          instructions: instructions,
          reason: reason,
          dateAdded: dateAdded,
          dateUpdated: dateUpdated,
        );

  factory MedicationModel.fromJSON(Map<String, dynamic> json) =>
      MedicationModel(
        medicationID: json['medication_id'],
        medicationName: json['medication_name'],
        drugClass: json['drug_class'],
        drugBrand: json['drug_brand'],
        drugCode: json['drug_code'],
        drugType: json['drug_type'],
        drugStrength: json['drug_strength'],
        form: json['form'],
        adminRoute: json['admin_route'],
        dose: num.parse('${json['dose'] ?? '0'}').toInt(),
        doseHours: (json['dose_hours'] as List<dynamic>)
            .map<String>((s) => '$s')
            .toList(),
        frequency: num.parse('${json['frequency'] ?? '0'}').toInt(),
        instructions: json['instructions'],
        reason: json['reason'],
        dateAdded: DateTime.parse(
            json['date_added'] ?? DateTime.now().toIso8601String()),
        dateUpdated: DateTime.parse(
            json['date_updated'] ?? DateTime.now().toIso8601String()),
      );

  MedicationModel copyWith({
    String? medicationID,
    String? medicationName,
    String? drugClass,
    String? drugBrand,
    String? drugCode,
    String? drugType,
    String? drugStrength,
    String? form,
    String? adminRoute,
    int? dose,
    List<String>? doseHours,
    int? frequency,
    String? instructions,
    String? reason,
    DateTime? dateAdded,
    DateTime? dateUpdated,
  }) =>
      MedicationModel(
        medicationID: medicationID ?? this.medicationID,
        medicationName: medicationName ?? this.medicationName,
        drugClass: drugClass ?? this.drugClass,
        drugBrand: drugBrand ?? this.drugBrand,
        drugCode: drugCode ?? this.drugCode,
        drugType: drugType ?? this.drugType,
        drugStrength: drugStrength ?? this.drugStrength,
        form: form ?? this.form,
        adminRoute: adminRoute ?? this.adminRoute,
        dose: dose ?? this.dose,
        doseHours: doseHours ?? this.doseHours,
        frequency: frequency ?? this.frequency,
        instructions: instructions ?? this.instructions,
        reason: reason ?? this.reason,
        dateAdded: dateAdded ?? this.dateAdded,
        dateUpdated: dateUpdated ?? this.dateUpdated,
      );

  factory MedicationModel.copyFromMedication(Medication medication) =>
      MedicationModel(
        medicationID: medication.medicationID,
        medicationName: medication.medicationName,
        drugClass: medication.drugClass,
        drugBrand: medication.drugBrand,
        drugCode: medication.drugCode,
        drugType: medication.drugType,
        drugStrength: medication.drugStrength,
        form: medication.form,
        adminRoute: medication.adminRoute,
        dose: medication.dose,
        doseHours: medication.doseHours,
        frequency: medication.frequency,
        instructions: medication.instructions,
        reason: medication.reason,
        dateAdded: medication.dateAdded,
        dateUpdated: medication.dateUpdated,
      );

  Map<String, dynamic> toJson() => {
        'medication_id': medicationID,
        'medication_name': medicationName,
        'drug_class': drugClass,
        'drug_brand': drugBrand,
        'drug_code': drugCode,
        'drug_type': drugType,
        'drug_strength': drugStrength,
        'form': form,
        'admin_route': adminRoute,
        'dose': dose,
        'dose_hours': doseHours,
        'frequency': frequency,
        'instructions': instructions,
        'reason': reason,
        'date_added': dateAdded.toIso8601String(),
        'date_updated': dateUpdated.toIso8601String(),
      };

  @override
  List<Object?> get props => [medicationName, drugClass, drugCode, drugType];
}
