import 'package:get/get.dart';

class AssetDetailState {
  late final int id;
  AssetDetailState() {
    id = Get.arguments?['id']??'';
  }
}
