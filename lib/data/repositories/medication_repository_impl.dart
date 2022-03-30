import 'package:care_monitor/core/utils/exceptions.dart';
import 'package:care_monitor/data/datasources/remote_data_source.dart';
import 'package:care_monitor/data/models/medication_modal.dart';
import 'package:care_monitor/domain/entities/medication.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:care_monitor/domain/repositories/medication_repository.dart';
import 'package:dartz/dartz.dart';

/// Implments [MedicationRepository], connects usecases with remote and local data sources.
/// 
/// Requires [RemoteDataSource] for reading and writing to device storage.
class MedicationRepositoryImpl extends MedicationRepository {
  final RemoteDataSource _dataSource;

  MedicationRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, void>> addMedication(Medication medication) async {
    try {
      return Right(
        await _dataSource
            .addMedication(MedicationModel.copyFromMedication(medication)),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMedication(String medicationID) async {
    try {
      return Right(await _dataSource.deleteMedication(medicationID));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> editMedication(
      String medicationID, Medication medication) async {
    try {
      return Right(await _dataSource.editMedication(
          medicationID, MedicationModel.copyFromMedication(medication)));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Medication>>> fetchAllMedicines() async {
    try {
      return Right(await _dataSource.fetchAllMedicines());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> searchMedication(
      String medicationName) async {
    try {
      return Right(await _dataSource.searchMedication(medicationName));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
