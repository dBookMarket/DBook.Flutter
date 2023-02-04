import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'assets_inner_state.dart';
class AssetsInnerLogic extends GetxController with GetSingleTickerProviderStateMixin{
  final AssetsInnerState state = AssetsInnerState();
  @override
  void onInit() {
    state.tabController  = TabController(vsync: this, length: state.filter.length);
    super.onInit();
  }
}
