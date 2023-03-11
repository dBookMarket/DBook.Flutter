import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:get/get.dart';

import '../../../common/store/trade.dart';
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
    var result = await TradeStore.to.approveAll(state.issuesInfo.value.token?.blockChain);
    if(!result) return;
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
