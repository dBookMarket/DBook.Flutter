import 'package:dbook/common/utils/logger.dart';
import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingPasswordState extends BaseState{
  late String memories;

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordAgainController = TextEditingController();

  final hint = true.obs;

  SettingPasswordState() {
    memories = Get.arguments?['memories'] ?? '';
  }
}
