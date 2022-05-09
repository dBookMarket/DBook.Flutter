import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/utils/loading.dart';
import 'package:get/get.dart';

import 'asset_detail_state.dart';

class AssetDetailLogic extends GetxController {
  final AssetDetailState state = AssetDetailState();



  getDetail()async{
    showLoading();
    await NetWork.getInstance().assetsDetail(state.id).onError((error, stackTrace) => dismissLoading());
    dismissLoading();
  }

  setMark()async{
    showLoading();
    await NetWork.getInstance().mark(issue: 4, page: 1,markId: 4).onError((error, stackTrace) => showError(t: error.toString()));
    dismissLoading();
  }

  @override
  void onInit() {
    setMark();
    super.onInit();
  }
}
