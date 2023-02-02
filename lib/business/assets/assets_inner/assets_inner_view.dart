import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/config/app_config.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fontSize.dart';
import 'assets_inner_logic.dart';

class AssetsInnerPage extends StatelessWidget {
  final logic = Get.put(AssetsInnerLogic());
  final state = Get.find<AssetsInnerLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 200,maxHeight: 1.sh),
      margin: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH),
      child: Column(children: [
        Material(child: _filter(), color: Color(0xFFFFF7EC)),
        Expanded(child: _pageView()),
      ],),
    );
  }

  PreferredSizeWidget _filter() {
    return TabBar(
      controller: state.tabController,
      tabs: state.filter
          .map((e) => Tab(
        text: e,
        height: 64.h,
      ))
          .toList(),
      labelPadding: EdgeInsets.symmetric(horizontal: 20.w),
      indicatorWeight: 1.h,
      indicatorPadding: EdgeInsets.only(
        bottom: 1.h,
      ),
      indicatorColor: Color(0xFF42392B),
      // indicator: UnderlineTabIndicatorX(insets: EdgeInsets.only(left: 50.w, right: 50.w, bottom: 20.h, top: 20.h), borderSide: BorderSide(width: 10.h, color: ColorX.selected)),
      labelColor: Color(0xFF42392B),
      unselectedLabelColor: Color(0xFF98866E),
      labelStyle: TextStyle(fontSize: FontSizeX.s13),
      unselectedLabelStyle: TextStyle(fontSize: FontSizeX.s13),
    );
  }

  Widget _pageView() {
    return TabBarView(
      children: state.pages,
      physics: NeverScrollableScrollPhysics(),
      controller: state.tabController,
    );
  }
}
