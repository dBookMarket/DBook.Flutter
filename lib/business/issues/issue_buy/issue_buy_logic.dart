import 'package:get/get.dart';

import '../../../common/store/web3.dart';
import '../../../common/utils/logger.dart';
import '../../service_api/base/net_work.dart';
import 'issue_buy_state.dart';

class IssueBuyLogic extends GetxController {
  final IssueBuyState state = IssueBuyState();


  getChainType() async {
    state.setBusy();
    var result = await NetWork.getInstance().assets.issueDetail(issueId: state.tradeInfo.issue?.id ?? '');
    state.setIdle();
    state.chainType = result.token?.blockChain;
  }

  buy()async{
    state.setBusy();
    var chainType = Web3Store.to.formatChainType(state.chainType??'');
    if(chainType == null) {
      state.setError(t: 'invalid chain');
      return ;
    }

    if(state.tradeInfo.price == null) {
      state.setError(t: 'invalid price');
      return ;
    }

    num amount = state.quantity*state.tradeInfo.price!;

    logX.d('amount>>>>>>$amount  quantity>>>>>>${state.quantity}  price>>>>>>${state.tradeInfo.price}');

    try {
      var isApproved = await Web3Store.to.setApprovalForTrade(chainType,amount);
      state.setIdle();
      logX.d('授权结果1>>>>>>$isApproved');
    } catch (e) {
      state.setError(t: e.toString());
    }

    var result = await Web3Store.to.paySecondTrade(nftAmount: state.quantity, seller: state.tradeInfo.user?.address, chainType: chainType, nftId: state.tradeInfo.issue?.book?.id, tradeValue: amount);
    logX.d('fee>>>>>>$result');


    await NetWork.getInstance().market.transaction(tradeId: state.tradeInfo.id, quantity: state.quantity,status: state.tradeInfo.issue?.status,hash: result);
  }

  updateQuantity(int value) {
    state.quantity = value;
  }

  @override
  void onInit() {
    getChainType();
    super.onInit();
  }
}
