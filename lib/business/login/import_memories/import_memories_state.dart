import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ImportMemoriesState {
  ImportMemoriesState() {
    controller.text = testM;
  }

  final memories = ''.obs;

  final testM = 'upon session bone daughter blue surge reason rigid rally party inform state';
  TextEditingController controller = TextEditingController();
}
