import 'package:dbook/business/issues/secondary_market/secondary_market_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SecondaryMarketLogic extends GetxController with GetSingleTickerProviderStateMixin{
  final SecondaryMarketState state = SecondaryMarketState();

  @override
  void onInit() {
    state.tabController  = TabController(vsync: this, length: state.filter.length,);
    super.onInit();
  }
}
