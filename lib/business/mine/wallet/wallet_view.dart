import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fontSize.dart';
import '../../../common/widgets/appBar.dart';
import '../../../common/widgets/flutter_copy/tab_indicator.dart';
import '../../../common/widgets/text.dart';
import 'wallet_logic.dart';

class WalletPage extends StatelessWidget {
  final logic = Get.put(WalletLogic());
  final state = Get.find<WalletLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: 'Wallet',
        bottom: _filter(),
      ),
      body: _pageView(),
    );
  }

  PreferredSizeWidget _filter() {
    return TabBar(
      controller: state.tabController,
      tabs: state.filter
          .asMap()
          .keys
          .map((index) => Container(
        // color: Colors.red,
        padding: EdgeInsets.only(bottom: 20.h),
        child: Obx(() {
          var selected = state.pageIndex.value == index;
          return TextX(state.filter[index], fontSize: FontSizeX.s13, color: selected ? ColorX.txtTitle : ColorX.txtHint);
        }),
        height: 60.h,
      ))
          .toList(),
      labelPadding: EdgeInsets.symmetric(horizontal: 20.w),
      indicatorColor: ColorX.txtTitle,
      indicatorWeight: 0.h,
      indicatorPadding: EdgeInsets.only(
        bottom: 0.h,
      ),
      indicator: UnderlineTabIndicatorX(insets: EdgeInsets.only(left: 130.w, right: 130.w, bottom: 0.h, top: 20.h), borderSide: BorderSide(width: 2.h, color: ColorX.txtTitle)),
      labelStyle: TextStyle(fontSize: FontSizeX.s13, color: ColorX.txtTitle),
      labelColor: ColorX.txtTitle,
      unselectedLabelColor: ColorX.txtDesc,
      unselectedLabelStyle: TextStyle(fontSize: FontSizeX.s13, color: ColorX.txtDesc),
    );
  }

  Widget _pageView() {
    return TabBarView(
      children: state.pages,
      controller: state.tabController,
    );
  }
}
