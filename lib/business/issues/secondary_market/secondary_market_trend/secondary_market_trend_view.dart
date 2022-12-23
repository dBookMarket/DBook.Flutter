import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'secondary_market_trend_logic.dart';

class SecondaryMarketTrendPage extends StatelessWidget {
  final logic = Get.put(SecondaryMarketTrendLogic());
  final state = Get.find<SecondaryMarketTrendLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
