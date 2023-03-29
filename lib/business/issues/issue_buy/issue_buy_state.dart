import 'package:get/get.dart';

import '../../../common/entities/trades_list_entity.dart';
import '../../../common/widgets/view_state/view_state.dart';

class IssueBuyState extends BaseState{
  final defaultQuantity = '1';
  late TradesListEntity tradeInfo;
  String? chainType;
  int? nftId;
  int quantity = 1;
  final royalty = 0.0.obs;
  IssueBuyState() {
    tradeInfo = Get.arguments?['tradeDetail'] ?? '';
  }
}