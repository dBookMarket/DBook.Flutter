import 'package:get/get.dart';

import '../../../common/store/web3.dart';
import '../../../common/utils/logger.dart';
import '../../login/verify_password/verify_password_view.dart';
import '../../service_api/base/net_work.dart';
import 'issue_buy_state.dart';

class IssueBuyLogic extends GetxController {
  final IssueBuyState state = IssueBuyState();


  getChainType() async {
    state.setBusy();
    var result = await NetWork.getInstance().assets.issueDetail(issueId: state.tradeInfo.issue?.id ?? '');
    state.setIdle();
    state.chainType = result.token?.blockChain;
    state.nftId = result.token?.id;
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

    var pwd = await Get.to(() => VerifyPasswordPage(verifyType: VerifyType.verifyPassword), opaque: false, duration: Duration.zero, transition: Transition.noTransition, fullscreenDialog: true);
    if(pwd == null) {
      state.setIdle();
      return false;
    }

    var isApproved = await Web3Store.to.setApprovalForTrade(type:chainType,amount:amount,pwd: pwd);
    if(!isApproved) {
      state.setError(t: 'approve failed');
      return ;
    }

    var result = await Web3Store.to.paySecondTrade(nftAmount: state.quantity, seller: state.tradeInfo.user?.address, chainType: chainType, nftId: state.nftId, tradeValue: amount,pwd: pwd);

    if(!result.toString().startsWith('0x')) {
      state.setError(t: 'trade failed\n${result.toString()}');
      return ;
    }

    await NetWork.getInstance().market.transaction(tradeId: state.tradeInfo.id, quantity: state.quantity,status: 'success',hash: result).onError((error, stackTrace) => state.setError(t: 'trade failed\n${error.toString()}'));
    state.setSuccess(t: 'buy success');
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
