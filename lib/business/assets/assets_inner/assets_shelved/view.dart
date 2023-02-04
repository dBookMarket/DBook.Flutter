import 'package:dbook/business/assets/assets_inner/assets_shelved/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AssetsShelvedPage extends StatelessWidget {
  final tag = DateTime.now().toString();
  AssetsShelvedLogic get logic => Get.find<AssetsShelvedLogic>(tag: tag);
  AssetsShelvedState get state => Get.find<AssetsShelvedLogic>(tag: tag).state;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsShelvedLogic());

    return Container();
  }
}
