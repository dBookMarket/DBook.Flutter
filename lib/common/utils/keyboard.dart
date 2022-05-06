import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeyboardX {
  static BuildContext context = Get.context!;
  static FocusScopeNode currentFocus = FocusScope.of(context);
  static void keyboardBack() {
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}