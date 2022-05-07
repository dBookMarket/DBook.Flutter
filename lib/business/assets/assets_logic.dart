import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/entities/assets_entity.dart';
import 'package:get/get.dart';

import '../../common/utils/logger.dart';
import 'assets_state.dart';

class AssetsLogic extends GetxController {
  final AssetsState state = AssetsState();




  Future<List<AssetsEntity>?> refresh({bool init = false, bool enableLoading = true}) async {
    try {
      // state.currentPageNum = state.pageNumFirst;
      state.refreshController.resetNoData();
      var data = await NetWork.getInstance().assets();
      if (data == null || data.isEmpty || data.length == 0) {
        state.list.clear();
        state.refreshController.refreshCompleted();
        state.refreshController.loadComplete();
      } else {
        state.list.clear();
        state.list.addAll(data);
        // state.list.refresh();
        state.refreshController.refreshCompleted();

      }
    } catch (e) {
      logX.e(e);
    }
  }

  @override
  void onInit() {
    refresh();
    super.onInit();
  }
}
