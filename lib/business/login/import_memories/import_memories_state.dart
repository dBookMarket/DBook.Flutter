import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ImportMemoriesState extends BaseState{
  ImportMemoriesState() {
    if(kDebugMode) controller.text = testM;
    // controller.text = testM;
  }

  final memories = ''.obs;

  final testM = kReleaseMode?'':'upon session bone daughter blue surge reason rigid rally party inform state';

  // final testM = '';
  TextEditingController controller = TextEditingController();
}
