import 'package:care_monitor/core/utils/exceptions.dart';
import 'package:care_monitor/data/datasources/remote_data_source.dart';
import 'package:care_monitor/data/models/medication_modal.dart';
import 'package:care_monitor/domain/entities/medication.dart';
import 'package:care_monitor/core/utils/failure.dart';
import 'package:care_monitor/domain/repositories/medication_repository.dart';
import 'package:dartz/dartz.dart';

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
  Future<Either<Failure, bool>> deleteMedication(String medicationID) {
    // TODO: implement deleteMedication
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> editMedication(
      String medicationID, Medication medication) {
    // TODO: implement editMedication
    throw UnimplementedError();
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
  Future<Either<Failure, List<Medication>>> searchMedication(
      String medicationName) {
    // TODO: implement searchMedication
    throw UnimplementedError();
  }
}
