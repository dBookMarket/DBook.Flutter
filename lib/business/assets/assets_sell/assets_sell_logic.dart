import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:get/get.dart';

import 'assets_sell_state.dart';

class AssetsSellLogic extends GetxController {
  final AssetsSellState state = AssetsSellState();


  getIssueDetail()async{
    state.setBusy();
    state.issuesInfo.value = await NetWork.getInstance().assets.issueDetail(issueId: state.issueId).onError((error, stackTrace) => state.setError(t: 'invalid issue'));
    state.setIdle();
  }

  updateQuantity(int value) {
    state.quantity = value;
  }

  sell()async{
    if(state.priceController.text.isEmpty){
      state.setError(t: 'price is empty');
      return;
    }

    state.setBusy();
    await NetWork.getInstance().market.sellIssue( price: state.priceController.text, issue: state.issueId, quantity: state.quantity,isEdit: state.isEdit,tradeId: state.tradeId).onError((error, stackTrace) => state.setError(t: 'sell failed'));
    state.setIdle();
    Get.back(result: true);
  }


  @override
  void onInit() {
    getIssueDetail();
    super.onInit();
  }
}
