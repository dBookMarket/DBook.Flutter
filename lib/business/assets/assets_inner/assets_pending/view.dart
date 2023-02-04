import 'package:dbook/business/assets/assets_inner/assets_pending/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AssetsPendingPage extends StatelessWidget {
  final tag = DateTime.now().toString();
  AssetsPendingLogic get logic => Get.find<AssetsPendingLogic>(tag: tag);
  AssetsPendingState get state => Get.find<AssetsPendingLogic>(tag: tag).state;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsPendingLogic());

    return Container();
  }
}
