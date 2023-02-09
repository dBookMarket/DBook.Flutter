import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'asset_publish_logic.dart';

class AssetPublishPage extends StatelessWidget {
  final logic = Get.put(AssetPublishLogic());
  final state = Get.find<AssetPublishLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
