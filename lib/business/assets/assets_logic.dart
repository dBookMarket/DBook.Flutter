import 'package:dbook/business/login/verify_password/verify_password_view.dart';
import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/entities/assets_entity.dart';
import 'package:dbook/common/entities/assets_info_entity.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../common/utils/logger.dart';
import 'assets_state.dart';

class AssetsLogic extends GetxController {
  final AssetsState state = AssetsState();




  // refresh({bool init = false, bool enableLoading = true}) async {
  //   state.refreshController.resetNoData();
  //   var data = await NetWork.getInstance().assets().onError((error, stackTrace) => handleError(error));
  //   try {
  //     // state.currentPageNum = state.pageNumFirst;
  //     if (data == null || data.isEmpty || data.length == 0) {
  //       state.list.clear();
  //       state.refreshController.refreshCompleted();
  //       state.refreshController.loadComplete();
  //     } else {
  //       state.list.clear();
  //       state.list.addAll(data);
  //       // state.list.refresh();
  //       state.refreshController.refreshCompleted();
  //
  //     }
  //   } catch (e) {
  //     state.refreshController.refreshCompleted();
  //     logX.e(e);
  //   }
  // }

  handleError(error)async{
    logX.d(error);
    state.refreshController.refreshCompleted();
    if(error is DioError && error.response?.statusCode == 401){
      var result = await Get.dialog(VerifyPasswordPage(verifyType: VerifyType.reLogin,),barrierDismissible: false);
      if(result) refresh();
    }

  }

  Future<AssetsInfoEntity> loadData({int? pageNum})async{
    return await NetWork.getInstance().assets.assets().onError((error, stackTrace) => handleError(error));
  }

  refresh({bool init = false, bool enableLoading = true}) async {
    try {
      state.currentPageNum = state.pageNumFirst;
      state.refreshController.resetNoData();
      AssetsInfoEntity assets =  await loadData(pageNum: state.pageNumFirst);
      List<AssetsInfoResults>? data = assets.results;
      if (data == null || data.isEmpty || data.length == 0) {
        state.list.clear();
        state.refreshController.refreshCompleted();
        state.refreshController.loadComplete();
      } else {
        state.list.clear();
        state.list.addAll(data);
        // state.list.refresh();
        state.refreshController.refreshCompleted();
        if (assets.next == null) {
          state.refreshController.loadNoData();
          state.canLoadMore = false;
        } else {
          state.refreshController.loadComplete();
          state.canLoadMore = true;
        }
      }
    } catch (e) {
      state.refreshController.refreshFailed();
      logX.e(e);
    }
  }


  Future loadMore() async {
    try {
      AssetsInfoEntity assets =  await loadData(pageNum: ++state.currentPageNum);
      List<AssetsInfoResults>? data = assets.results;
      if (data == null || data.isEmpty) {
        state.currentPageNum--;
        state.refreshController.loadNoData();
      } else {
        state.list.addAll(data);
        // onCompleted(data);
        if (assets.next == null) {
          state.refreshController.loadNoData();
        } else {
          state.refreshController.loadComplete();
        }
      }
      return data;
    } catch (e) {
      state.refreshController.loadFailed();
    }
  }


  @override
  void onInit() {
    refresh();
    super.onInit();
  }
}
