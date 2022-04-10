import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  static StorageService get to => Get.find();
  final box = GetStorage();

  Future<StorageService> init() async {
    await GetStorage.init();
    return this;
  }

  Future setString(String key, String value) async {
    return await box.write(key, value);
  }

  Future setBool(String key, bool value) async {
    return await box.write(key, value);
  }

  Future setList(String key, List<String> value) async {
    return await box.write(key, value);
  }

  String getString(String key) {
    return box.read(key) ?? '';
  }

  bool getBool(String key) {
    return box.read(key) ?? false;
  }

  List<String> getList(String key) {
    return box.read(key) ?? [];
  }

  Future remove(String key) async {
    return await box.remove(key);
  }

  Future erase() async {
    return await box.erase();
  }
}
