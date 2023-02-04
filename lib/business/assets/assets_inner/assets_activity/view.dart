import 'package:dbook/business/assets/assets_inner/assets_activity/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AssetsActivityPage extends StatelessWidget {
  final tag = DateTime.now().toString();
  AssetsActivityLogic get logic => Get.find<AssetsActivityLogic>(tag: tag);
  AssetsActivityState get state => Get.find<AssetsActivityLogic>(tag: tag).state;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsActivityLogic());

    return Container();
  }
}
