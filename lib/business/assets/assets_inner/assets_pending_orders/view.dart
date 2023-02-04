import 'package:dbook/business/assets/assets_inner/assets_pending_orders/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AssetsPendingOrdersPage extends StatelessWidget {
  final tag = DateTime.now().toString();
  AssetsPendingOrdersLogic get logic => Get.find<AssetsPendingOrdersLogic>(tag: tag);
  AssetsPendingOrdersState get state => Get.find<AssetsPendingOrdersLogic>(tag: tag).state;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsPendingOrdersLogic());

    return Container();
  }
}
