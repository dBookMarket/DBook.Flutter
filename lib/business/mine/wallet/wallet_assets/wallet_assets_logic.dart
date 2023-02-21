import 'package:dbook/common/store/store.dart';
import 'package:dbook/common/store/web3.dart';
import 'package:get/get.dart';

import 'wallet_assets_state.dart';

class WalletAssetsLogic extends GetxController {
  final WalletAssetsState state = WalletAssetsState();



  getBalance()async{
    var enableLoading = state.polygonMainBalance.value != state.defaultBalance;
    state.setBusy(enableLoading: enableLoading);
    state.polygonMainBalance.value = await Web3Store.to.getBalance(PublicChainType.polygon);
    state.polygonTokenBalance.value = await Web3Store.to.getTokenBalance(PublicChainType.polygon);
    state.bscMainBalance.value = await Web3Store.to.getBalance(PublicChainType.bnb);
    state.bscTokenBalance.value = await Web3Store.to.getTokenBalance(PublicChainType.bnb);
    Web3Store.to.getLog(UserStore.to.address);
    state.setIdle(enableLoading: enableLoading);
  }

  @override
  void onInit() {
    getBalance();
    super.onInit();
  }

}
