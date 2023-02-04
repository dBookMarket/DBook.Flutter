import 'package:dbook/business/assets/assets_inner/assets_draft/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AssetsDraftPage extends StatelessWidget {
  final tag = DateTime.now().toString();
  AssetsDraftLogic get logic => Get.find<AssetsDraftLogic>(tag: tag);
  AssetsDraftState get state => Get.find<AssetsDraftLogic>(tag: tag).state;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsDraftLogic());

    return Container();
  }
}
