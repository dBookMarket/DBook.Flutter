import 'package:dbook/common/store/store.dart';
import 'package:get/get.dart';

import 'mine_state.dart';

class MineLogic extends GetxController {
  final MineState state = MineState();
  @override
  void onInit() {
    UserStore.to.getUserInfo();
    super.onInit();
  }
}
