import 'package:dbook/business/issues/secondary_market/secondary_market_activity/secondary_market_activity_view.dart';
import 'package:dbook/business/issues/secondary_market/secondary_market_list/secondary_market_list_view.dart';
import 'package:dbook/business/issues/secondary_market/secondary_market_trend/secondary_market_trend_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/entities/issues_entity.dart';

class SecondaryMarketState {
  final filter = ['List','Activity','Trend'];
  final PageController pageController = PageController();
  late TabController tabController;
  List<Widget> pages = [];
  late String issueId;
  late IssuesEntity issuesInfo;
  SecondaryMarketState() {
    issuesInfo = Get.arguments?['detail'] ?? IssuesEntity();
    pages.add(SecondaryMarketListPage());
    pages.add(SecondaryMarketActivityPage());
    pages.add(SecondaryMarketTrendPage());
  }
}
