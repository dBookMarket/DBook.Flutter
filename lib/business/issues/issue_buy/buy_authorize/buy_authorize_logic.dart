import 'dart:math';

import 'package:get/get.dart';

import '../../../../common/store/web3.dart';
import 'buy_authorize_state.dart';

class BuyAuthorizeLogic extends GetxController {
  BuyAuthorizeState state = BuyAuthorizeState();

  @override
  void onInit() {
    super.onInit();
    getFee();
  }

  getFee() async {
    state.setBusy();
    var fee = await Web3Store.to.getGasFee(state.chainType);
    final _random = new Random();
    int next(int min, int max) => min + _random.nextInt(max - min);
    state.transactionFee.value = (fee*next(99500, 100000)/100000).toStringAsFixed(9);
    state.setIdle();
  }
}
