import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'secondary_market_activity_logic.dart';

class SecondaryMarketActivityPage extends StatelessWidget {
  final logic = Get.put(SecondaryMarketActivityLogic());
  final state = Get.find<SecondaryMarketActivityLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
