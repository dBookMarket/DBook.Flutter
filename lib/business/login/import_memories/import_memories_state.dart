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

  final testM = '';
  TextEditingController controller = TextEditingController();
}
