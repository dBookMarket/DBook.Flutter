import 'package:dbook/business/mine/wallet/wallet_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class WalletLogic extends GetxController with GetSingleTickerProviderStateMixin {
  final WalletState state = WalletState();

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
