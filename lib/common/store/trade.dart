import 'package:dbook/business/assets/asset_publish/publish_authorize/publish_authorize_view.dart';
import 'package:dbook/common/store/web3.dart';
import 'package:dbook/common/utils/loading.dart';
import 'package:get/get.dart';

import '../../business/issues/issue_buy/buy_authorize/buy_authorize_view.dart';
import '../../business/login/verify_password/verify_password_view.dart';
import '../utils/logger.dart';

class TradeStore extends GetxController {
  static TradeStore get to => Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  // 授权所有
  Future<bool> approveAll(String? publicChain) async {
    var chainType = Web3Store.to.formatChainType(publicChain);
    if (chainType == null) {
      showError(t: 'invalid chain');
      return false;
    }

    // 每次都需要授权
    bool isApproved = await Web3Store.to.isApprovedForAll(chainType);
    logX.d('是否授权>>>>>>$isApproved');

    if (isApproved) {
      return true;
    }
    var pwd = await Get.to(() => VerifyPasswordPage(verifyType: VerifyType.verifyPassword), opaque: false, duration: Duration.zero, transition: Transition.noTransition, fullscreenDialog: true);
    if (pwd == null) {
      showError(t: 'Cancel');
      return false;
    }

    await Future.delayed(Duration(milliseconds: 200));
    dismissLoading();
    bool? authorize = await Get.to(() => PublishAuthorizePage(), arguments: {'chainType': chainType});
    if (authorize == null) {
      showError(t: 'Cancel');
      return false;
    }
    showLoading();

    try {
      var tx = await Web3Store.to.setApprovalForAll(chainType, pwd);
      if (!tx.toString().startsWith('0x')) {
        showError(t: 'approveAll failed\n${tx.toString()}');
        return false;
      }
      return true;
    } catch (e) {
      showError(t: 'setApprovalForAll error$e');
      return false;
    }
  }

  //购买一级市场的NFT
  Future<bool> buyPrimaryMarket({required String? publicChain, required int quantity, required double price, required String? cover, required String? bookName, required String? issueId}) async {
    var chainType = Web3Store.to.formatChainType(publicChain);
    if (chainType == null) {
      showError(t: 'invalid chain');
      return false;
    }
    var pwd = await Get.to(() => VerifyPasswordPage(verifyType: VerifyType.verifyPassword), opaque: false, duration: Duration.zero, transition: Transition.noTransition, fullscreenDialog: true);
    if (pwd == null) {
      showError(t: 'Cancel');
      return false;
    }

    var tx = await Web3Store.to.setApprovalForTrade(type: chainType, amount: quantity * price, pwd: pwd);
    if (!tx.toString().startsWith('0x')) {
      showError(t: 'approve failed\n${tx.toString()}');
      return false;
    }

    dismissLoading();
    var buyConfirm = await Get.to(() => BuyAuthorizePage(),
        arguments: {'chainType': chainType, 'to': Web3Store.to.contractAddress(AbiType.platform, chainType).hex, 'quantity': quantity, 'price': price, 'cover': cover, 'bookName': bookName});
    if (buyConfirm == null) {
      showError(t: 'Cancel');
      return false;
    }
    showLoading();

    var hash = await Web3Store.to.payFirstTrade(type: chainType, price: price, amount: quantity, pwd: pwd);
    print('hash>>>>>>$hash');
    if (!hash.toString().startsWith('0x')) {
      showError(t: 'pay failed\n${hash.toString()}');
      return false;
    }
    return true;
  }

  //购买二级市场的NFT
  Future<String?> buySecondaryMarket(
      {required String? publicChain,
      required num amount,
      required int quantity,
      required String seller,
      required int nftId,
      required String? cover,
      required String? bookName,
      required String? issueId}) async {
    var chainType = Web3Store.to.formatChainType(publicChain);
    if (chainType == null) {
      showError(t: 'invalid chain');
      return null;
    }

    var pwd = await Get.to(() => VerifyPasswordPage(verifyType: VerifyType.verifyPassword), opaque: false, duration: Duration.zero, transition: Transition.noTransition, fullscreenDialog: true);
    if (pwd == null) {
      showError(t: 'Cancel');
      return null;
    }

    var tx = await Web3Store.to.setApprovalForTrade(type: chainType, amount: amount, pwd: pwd);
    if (!tx.toString().startsWith('0x')) {
      showError(t: 'approve failed\n${tx.toString()}');
      return null;
    }

    dismissLoading();
    var buyConfirm = await Get.to(() => BuyAuthorizePage(), arguments: {'chainType': chainType, 'to': seller, 'quantity': quantity, 'price': amount, 'cover': cover, 'bookName': bookName});
    if (buyConfirm == null) {
      showError(t: 'Cancel');
      return null;
    }
    showLoading();

    var payResult = await Web3Store.to.paySecondTrade(nftAmount: quantity, seller: seller, chainType: chainType, nftId: nftId, tradeValue: amount, pwd: pwd);
    if (!payResult.toString().startsWith('0x')) {
      showError(t: 'trade failed\n${payResult.toString()}');
      return null;
    }

    return payResult;
  }
}
