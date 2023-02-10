import 'package:dbook/business/assets/assets_inner/assets_activity/view.dart';
import 'package:dbook/business/assets/assets_inner/assets_author_collection/view.dart';
import 'package:dbook/business/assets/assets_inner/assets_draft/view.dart';
import 'package:dbook/business/assets/assets_inner/assets_earnings/view.dart';
import 'package:dbook/business/assets/assets_inner/assets_my_collection/view.dart';
import 'package:dbook/business/assets/assets_inner/assets_pending/view.dart';
import 'package:dbook/business/assets/assets_inner/assets_pending_orders/view.dart';
import 'package:dbook/business/assets/assets_inner/assets_shelved/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../assets_state.dart';

class AssetsInnerState {
  late List<String> filter;
  List<Widget> pages = [];
  late AssetsType assetsType;
  final PageController pageController = PageController();
  late TabController tabController;
  late String issueId;

  AssetsInnerState() {
    assetsType = Get.arguments?['assetsType'] ?? AssetsType.MY_BOOKS;
    if (assetsType == AssetsType.MY_BOOKS) {
      filter = ['My Collection', 'Pending orders', 'Earnings'];
      pages.add(AssetsMyCollectionPage());
      pages.add(AssetsPendingOrdersPage());
      pages.add(AssetsEarningsPage());
    } else if (assetsType == AssetsType.MY_ASSETS) {
      filter = ['Draft', 'Pending', 'Shelved', 'Earnings'];
      pages.add(AssetsDraftPage());
      pages.add(AssetsPendingPage());
      pages.add(AssetsShelvedPage());
      pages.add(AssetsEarningsPage());
    } else if (assetsType == AssetsType.AUTHOR) {
      filter = ['Publish books', 'Activity', 'Collectibles'];
      pages.add(AssetsPendingPage());
      pages.add(AssetsActivityPage());
      pages.add(AssetsAuthorCollectionPage());
    }
  }
}
