import 'package:dbook/business/mine/wallet/wallet_activity/wallet_activity_view.dart';
import 'package:dbook/business/mine/wallet/wallet_assets/wallet_assets_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletState {
  final filter = ['Assets', 'Activity'];
  final PageController pageController = PageController();
  late TabController tabController;
  List<Widget> pages = [];

  final pageIndex = 0.obs;
  WalletState() {
    pages.add(WalletAssetsPage());
    pages.add(WalletActivityPage());
  }
}
