import 'dart:async';

import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:flutter/cupertino.dart';

class ImportPrivateKeyState extends BaseState{
  FocusNode memoriesFocus = FocusNode();
  late StreamSubscription<bool> keyboardSubscription;
  TextEditingController memoriesInputController = TextEditingController();
  String memories = '';
  ImportPrivateKeyState() {
    ///Initialize variables
  }
}
