import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ImportMemoriesState {
  ImportMemoriesState() {
    if(kDebugMode) controller.text = testM;
    // controller.text = testM;
  }

  final memories = ''.obs;

  final testM = 'upon session bone daughter blue surge reason rigid rally party inform state';

  // final testM = '';
  TextEditingController controller = TextEditingController();
}
