import 'package:dbook/business/assets/assets_inner/assets_earnings/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AssetsEarningsPage extends StatelessWidget {
  final tag = DateTime.now().toString();
  AssetsEarningsLogic get logic => Get.find<AssetsEarningsLogic>(tag: tag);
  AssetsEarningsState get state => Get.find<AssetsEarningsLogic>(tag: tag).state;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsEarningsLogic());

    return Container();
  }
}
