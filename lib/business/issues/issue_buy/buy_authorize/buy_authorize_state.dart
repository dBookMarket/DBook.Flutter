import '../../../../common/store/user.dart';
import '../../../../common/store/web3.dart';
import '../../../../common/utils/string_helper.dart';
import '../../../../common/widgets/view_state/view_state.dart';
import 'package:get/get.dart';

import '../../../../generated/assets.dart';

class BuyAuthorizeState extends BaseState {
  late PublicChainType chainType;
  String chainTitle = '';
  String from = UserStore.to.address ?? '';
  String to = '';
  String cover = '';
  String bookName = '';
  int quantity = 0;
  num price = 0.0;
  String total = '';

  final transactionFee = ''.obs;
  String coinCover = '';

  BuyAuthorizeState() {
    chainType = Get.arguments?['chainType'];
    to = Get.arguments?['to'];
    quantity = Get.arguments?['quantity'];
    price = Get.arguments?['price'];
    cover = Get.arguments?['cover'];
    bookName = Get.arguments?['bookName'];

    if (chainType == PublicChainType.bnb) {
      chainTitle = 'BNB Smart Chain';
      coinCover = Assets.svgCoinBnb;
    } else {
      chainTitle = 'Polygon MainNet';
      coinCover = Assets.svgCoinMatic;
    }

    total = removeZero((quantity * price).toString()) + ' USDC';
  }
}
