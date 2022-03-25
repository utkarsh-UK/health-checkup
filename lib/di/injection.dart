import 'package:care_monitor/data/datasource_impl/remote_datasource_impl.dart';
import 'package:care_monitor/data/datasources/remote_data_source.dart';
import 'package:care_monitor/data/repositories/medication_repository_impl.dart';
import 'package:care_monitor/data/services/storage_service.dart';
import 'package:care_monitor/domain/repositories/medication_repository.dart';
import 'package:care_monitor/domain/usecases/medication/add_medication.dart';
import 'package:care_monitor/domain/usecases/medication/delete_medication.dart';
import 'package:care_monitor/domain/usecases/medication/edit_medication.dart';
import 'package:care_monitor/domain/usecases/medication/fetch_medications.dart';
import 'package:care_monitor/domain/usecases/medication/search_medication.dart';
import 'package:get/get.dart';

class DependencyInjector {
  void inject() {
    // remote data source
    Get.lazyPut<RemoteDataSource>(
      () => RemoteDatasourceImpl(Get.find<StorageService>()),
    );

    // repositories
    Get.lazyPut<MedicationRepository>(
      () => MedicationRepositoryImpl(Get.find<RemoteDataSource>()),
    );

    // usecases
    Get.lazyPut(() => AddMedication(Get.find<MedicationRepository>()));
    Get.lazyPut(() => EditMedication(Get.find<MedicationRepository>()));
    Get.lazyPut(() => DeleteMedication(Get.find<MedicationRepository>()));
    Get.lazyPut(() => SearchMedication(Get.find<MedicationRepository>()));
    Get.lazyPut(() => FetchMedication(Get.find<MedicationRepository>()));
  }
}
