import 'dart:async';

import 'package:flutter/cupertino.dart';

class ImportPrivateKeyState {
  FocusNode memoriesFocus = FocusNode();
  late StreamSubscription<bool> keyboardSubscription;
  TextEditingController memoriesInputController = TextEditingController();
  String memories = '';
  ImportPrivateKeyState() {
    ///Initialize variables
  }
}
