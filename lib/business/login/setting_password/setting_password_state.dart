import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingPasswordState {
  late String memories;

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordAgainController = TextEditingController();

  final hint = true.obs;

  SettingPasswordState() {
    memories = Get.arguments?['memories'] ?? '';
  }
}
