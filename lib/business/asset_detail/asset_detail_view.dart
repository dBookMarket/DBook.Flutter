import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'asset_detail_logic.dart';

class AssetDetailPage extends StatelessWidget {
  final logic = Get.put(AssetDetailLogic());
  final state = Get.find<AssetDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red,);
  }
}
