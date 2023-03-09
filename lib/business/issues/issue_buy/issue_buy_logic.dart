import 'package:dbook/common/store/trade.dart';
import 'package:get/get.dart';

import '../../../common/entities/transactions_list_entity.dart';
import '../../../common/store/order.dart';
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

  buy() async {
    state.setBusy();
    if (state.tradeInfo.price == null) {
      state.setError(t: 'invalid price');
      return;
    }
    num amount = state.quantity * state.tradeInfo.price!;

    String? result = await TradeStore.to.buySecondaryMarket(
        publicChain: state.chainType ?? '',
        amount: amount,
        quantity: state.quantity,
        seller: state.tradeInfo.user?.address ?? '',
        nftId: state.nftId ?? 0,
        cover: state.tradeInfo.issue?.book?.coverUrl,
        bookName: state.tradeInfo.issue?.book?.title,
        issueId: state.tradeInfo.issue?.id,
    );
    if (result == null) {
      return;
    }

    TransactionsListEntity tx = await NetWork.getInstance()
        .market
        .transaction(tradeId: state.tradeInfo.id, quantity: state.quantity, status: 'success', hash: result)
        .onError((error, stackTrace) => state.setError(t: 'trade failed\n${error.toString()}'));
    state.setSuccess(t: 'buy success');

    OrderStore.to.saveOrder(tx);
    Get.back();
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
