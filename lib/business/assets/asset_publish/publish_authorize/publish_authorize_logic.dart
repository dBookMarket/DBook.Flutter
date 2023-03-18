import 'package:dbook/common/store/web3.dart';
import 'package:get/get.dart';

class PublishAuthorizeLogic extends GetxController {
  final String content = 'Allow dBookMarket to access your NFT?';
  final String desc =
      'First book release/first order must agree to this license.';
  final String feeDesc = 'Expect to pay the gas fee:';
  final String bnbGasPrice = '≈0.00067757 BNB';
  final String maticGasPrice = '≈0.00026847 MATIC';
  final String fileCoinGasPrice = '≈0.00026847 attoFIL';

  PublicChainType? chainType;
  final gasPrice = ''.obs;

  @override
  void onInit() {
    super.onInit();
    chainType = Get.arguments?['chainType'];
    if (chainType == PublicChainType.bnb) {
      gasPrice.value = bnbGasPrice;
    } else if (chainType == PublicChainType.filecoin) {
      gasPrice.value = fileCoinGasPrice;
    } else if (chainType == PublicChainType.polygon){
      gasPrice.value = maticGasPrice;
    }
  }
}
