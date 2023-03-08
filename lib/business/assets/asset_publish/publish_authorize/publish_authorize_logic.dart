import 'package:dbook/common/store/web3.dart';
import 'package:get/get.dart';

class PublishAuthorizeLogic extends GetxController {
  final String content = 'Allow dBookMarket to access your NFT?';
  final String desc =
      'To publish a book for the first time, you must agree to this authorization. After agreeing to the authorization, if you need to purchase books from other authors, it is recommended to change the account. This account is only recommended for publishing/receiving purposes.';
  final String feeDesc = 'There is a processing fee for this request';
  final String bnbGasPrice = '≈0.00067757BNB';
  final String maticGasPrice = '≈0.00026847 MATIC';

  PublicChainType? chainType;
  final gasPrice = ''.obs;

  @override
  void onInit() {
    super.onInit();
    chainType = Get.arguments?['chainType'];
    if (chainType == PublicChainType.bnb) {
      gasPrice.value = bnbGasPrice;
    } else {
      gasPrice.value = maticGasPrice;
    }
  }
}
