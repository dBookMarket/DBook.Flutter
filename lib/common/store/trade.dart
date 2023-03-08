import 'package:dbook/business/assets/asset_publish/publish_authorize/publish_authorize_view.dart';
import 'package:dbook/common/store/web3.dart';
import 'package:dbook/common/utils/loading.dart';
import 'package:get/get.dart';

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
    var pwd = await Get.to(() => VerifyPasswordPage(verifyType: VerifyType.verifyPassword),
        opaque: false, duration: Duration.zero, transition: Transition.noTransition, fullscreenDialog: true);
    if (pwd == null) {
      showError(t: 'Cancel');
      return false;
    }

    bool? authorize = await Get.to(()=>PublishAuthorizePage());
    if(authorize == null){
      showError(t: 'Cancel');
      return false;
    }

    try {
      await Web3Store.to.setApprovalForAll(chainType, pwd);
      return true;
    } catch (e) {
      showError(t: 'setApprovalForAll error');
      return false;
    }
  }

  //购买一级市场的NFT
  Future<bool> buyPrimaryMarket({required String? publicChain, required int amount, required double price}) async {
    var chainType = Web3Store.to.formatChainType(publicChain);
    if (chainType == null) {
      showError(t: 'invalid chain');
      return false;
    }
    var pwd = await Get.to(() => VerifyPasswordPage(verifyType: VerifyType.verifyPassword),
        opaque: false, duration: Duration.zero, transition: Transition.noTransition, fullscreenDialog: true);
    if (pwd == null) {
      showError(t: 'Cancel');
      return false;
    }

    // todo 手续费
    try {
      await Web3Store.to.payFirstTrade(type: chainType, price: price, amount: amount, pwd: pwd);
      return true;
    } catch (e) {
      showError(t: 'pay failed');
      return false;
    }
  }

  //购买二级市场的NFT
  Future<String?> buySecondaryMarket(
      {required String? publicChain, required num amount, required int quantity, required String seller, required int nftId}) async {
    var chainType = Web3Store.to.formatChainType(publicChain);
    if (chainType == null) {
      showError(t: 'invalid chain');
      return null;
    }

    var pwd = await Get.to(() => VerifyPasswordPage(verifyType: VerifyType.verifyPassword),
        opaque: false, duration: Duration.zero, transition: Transition.noTransition, fullscreenDialog: true);
    if (pwd == null) {
      showError(t: 'Cancel');
      return null;
    }
    // todo 手续费
    var isApproved = await Web3Store.to.setApprovalForTrade(type: chainType, amount: amount, pwd: pwd);
    if (!isApproved) {
      showError(t: 'approve failed');
      return null;
    }

    // todo 手续费
    var payResult = await Web3Store.to.paySecondTrade(nftAmount: quantity, seller: seller, chainType: chainType, nftId: nftId, tradeValue: amount, pwd: pwd);
    if (!payResult.toString().startsWith('0x')) {
      showError(t: 'trade failed\n${false.toString()}');
      return null;
    }

    return payResult;
  }
}
