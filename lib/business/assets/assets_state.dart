import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/entities/user_info_entity.dart';
import 'assets_inner/assets_activity/view.dart';
import 'assets_inner/assets_author_collection/view.dart';
import 'assets_inner/assets_draft/view.dart';
import 'assets_inner/assets_earnings/view.dart';
import 'assets_inner/assets_my_collection/view.dart';
import 'assets_inner/assets_pending/view.dart';
import 'assets_inner/assets_pending_orders/view.dart';
import 'assets_inner/assets_shelved/view.dart';

enum AssetsType{
  MY_ASSETS,
  MY_BOOKS,
  AUTHOR,
}

class AssetsState extends BaseState{
  String? userId;
  late AssetsType assetsType;
  final userInfo = UserInfoEntity().obs;


  final PageController pageController = PageController();
  late TabController tabController;
  late List<String> filter;
  List<Widget> pages = [];

  AssetsState() {
    userId = Get.arguments?['userId']??'';
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
