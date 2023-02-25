import 'package:dbook/common/utils/string_helper.dart';
import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/entities/issues_entity.dart';

class AssetsSellState extends BaseState{
  late String issueId;
  final issuesInfo = IssuesEntity().obs;
  final priceController = TextEditingController();
  String defaultQuantity = '1';
  int quantity = 1;
  bool isEdit = false;

  int? tradeId;
  AssetsSellState() {
    issueId = Get.arguments['issueId'] ?? '';

    if(Get.arguments['quantity']!=null&&Get.arguments['price']!=null&&Get.arguments['tradeId']!=null){
      isEdit = true;
      quantity = Get.arguments['quantity'];
      defaultQuantity = Get.arguments['quantity'].toString();
      tradeId = Get.arguments['tradeId'];
      priceController.text = removeZero(Get.arguments['price']);
    }

  }
}
