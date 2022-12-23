import 'package:dbook/business/issues/secondary_market/secondary_market_activity/secondary_market_activity_view.dart';
import 'package:dbook/business/issues/secondary_market/secondary_market_list/secondary_market_list_view.dart';
import 'package:dbook/business/issues/secondary_market/secondary_market_state.dart';
import 'package:dbook/business/issues/secondary_market/secondary_market_trend/secondary_market_trend_view.dart';
import 'package:dbook/common/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/widgets/text.dart';
import 'secondary_market_logic.dart';

class SecondaryMarketPage extends StatelessWidget {
  final logic = Get.put(SecondaryMarketLogic());
  final state = Get.find<SecondaryMarketLogic>().state;
  late String issueId;

  SecondaryMarketPage({required this.issueId}){
    state.issueId = this.issueId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      padding: EdgeInsets.symmetric(vertical: 26.r),
      height: 0.5.sh,
      decoration: BoxDecoration(
        border: Border.all(width: 1.r, color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 26.r),
              Container(
                width: 10.r,
                height: 10.r,
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(100)),
              ),
              SizedBox(width: 20.w),
              TextX('Secondary market', fontSize: FontSizeX.s16, color: Color(0xFF42392B), fontWeight: TextX.bold)
            ],
          ),
          SizedBox(height: 12.h),
          Material(child: _filter(),color: ColorX.primaryYellow,),
          Expanded(child: _pageView())
        ],
      ),
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
