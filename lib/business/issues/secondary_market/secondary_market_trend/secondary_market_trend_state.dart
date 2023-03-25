import 'package:dbook/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/entities/issues_entity.dart';
import '../../../../common/widgets/refresh_list_view/state.dart';

class SecondaryMarketTrendState extends RefreshListViewState{
  late IssuesEntity issuesInfo;

  List<Color> gradientColors = [
    ColorX.primaryYellow,
    ColorX.primaryYellow,
  ];

  SecondaryMarketTrendState() {
    this.initRefresh = false;
    this.disableShimmer = true;
    this.initData = true;
    issuesInfo = Get.arguments?['detail'] ?? IssuesEntity();
  }
}
