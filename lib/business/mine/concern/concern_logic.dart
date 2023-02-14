import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'concern_state.dart';

class ConcernLogic extends GetxController with GetSingleTickerProviderStateMixin{
  final ConcernState state = ConcernState();

  @override
  void onInit() {
    state.tabController  = TabController(vsync: this, length: state.filter.length,);
    _tabListener();
    super.onInit();
  }

  _tabListener(){
    state.tabController.addListener(() {
      state.pageIndex.value = state.tabController.index;
    });
  }
}
