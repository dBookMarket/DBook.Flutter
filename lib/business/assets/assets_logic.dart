import 'package:dbook/business/login/verify_password/verify_password_view.dart';
import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/entities/assets_entity.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../common/utils/logger.dart';
import 'assets_state.dart';

class AssetsLogic extends GetxController {
  final AssetsState state = AssetsState();




  refresh({bool init = false, bool enableLoading = true}) async {
    state.refreshController.resetNoData();
    var data = await NetWork.getInstance().assets().onError((error, stackTrace) => handleError(error));
    try {
      // state.currentPageNum = state.pageNumFirst;
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
      state.refreshController.refreshCompleted();
      logX.e(e);
    }
  }

  handleError(error)async{
    logX.d(error);
    state.refreshController.refreshCompleted();
    if(error is DioError && error.response?.statusCode == 401){
      var result = await Get.dialog(VerifyPasswordPage(verifyType: VerifyType.reLogin,),barrierDismissible: false);
      if(result) refresh();
    }

  }



  @override
  void onInit() {
    refresh();
    super.onInit();
  }
}
