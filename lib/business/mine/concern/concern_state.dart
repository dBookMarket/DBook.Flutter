import 'package:dbook/business/mine/concern/concern_author/concern_author_view.dart';
import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'concern_opus/concern_opus_view.dart';

class ConcernState extends BaseState{
  final filter = ['Books', 'Author'];
  final PageController pageController = PageController();
  late TabController tabController;
  List<Widget> pages = [];

  final pageIndex = 0.obs;
  ConcernState() {
    pages.add(ConcernOpusPage());
    pages.add(ConcernAuthorPage());
  }
}
