import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/entities/issues_entity.dart';
import '../../../../common/widgets/refresh_list_view/state.dart';

class SecondaryMarketTrendState extends RefreshListViewState{
  late IssuesEntity issuesInfo;

  List<Color> gradientColors = [
    const Color(0xff00A0E9),
    const Color(0xff4D85D0),
  ];

  SecondaryMarketTrendState() {
    this.initRefresh = false;
    this.disableShimmer = true;
    this.initData = true;
    issuesInfo = Get.arguments?['detail'] ?? IssuesEntity();
  }
}
