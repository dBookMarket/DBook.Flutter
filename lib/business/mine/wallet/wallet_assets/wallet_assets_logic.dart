import 'package:dbook/common/store/web3.dart';
import 'package:get/get.dart';

import 'wallet_assets_state.dart';

class WalletAssetsLogic extends GetxController {
  final WalletAssetsState state = WalletAssetsState();



  getBalance()async{
    var enableLoading = state.polygonMainBalance.value != state.defaultBalance;
    state.setBusy(enableLoading: enableLoading);
    await refreshData();
    state.setIdle(enableLoading: enableLoading);
  }

  refreshData()async{
    try {
      state.polygonMainBalance.value = await Web3Store.to.getBalance(PublicChainType.polygon);
      state.polygonTokenBalance.value = await Web3Store.to.getTokenBalance(PublicChainType.polygon);
      state.bscMainBalance.value = await Web3Store.to.getBalance(PublicChainType.bnb);
      state.bscTokenBalance.value = await Web3Store.to.getTokenBalance(PublicChainType.bnb);
      state.fileCoinBalance.value = await Web3Store.to.getBalance(PublicChainType.filecoin);
      state.fileCoinTokenBalance.value = await Web3Store.to.getTokenBalance(PublicChainType.filecoin);
    } catch (e) {
      state.refreshController.refreshFailed();
    }
    state.refreshController.refreshCompleted();
  }

  @override
  void onInit() {
    getBalance();
    super.onInit();
  }

}
