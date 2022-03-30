import 'package:care_monitor/core/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// Extends [GetxService] to implement read and writes to storage.
class StorageService extends GetxService {
  late GetStorage _box;

  Future<StorageService> init() async {
    _box = GetStorage();
    await _box.writeIfNull(Constants.medStorageKey, []);
    await _box.writeIfNull(Constants.docStorageKey, []);

    return this;
  }

  /// Reads and returns object of type [T] having storage key [key].
  T read<T>(String key) {
    return _box.read(key);
  }

  /// Writes [value] with [key].
  void write(String key, dynamic value) async {
    await _box.write(key, value);
  }
}
