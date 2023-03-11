import 'package:dbook/business/search/search_result/search_result_view.dart';
import 'package:dbook/common/values/colors.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'ads_issues/ads_issues_view.dart';
import 'search_logic.dart';

class SearchPage extends StatelessWidget {
  final logic = Get.put(SearchLogic());
  final state = Get.find<SearchLogic>().state;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
        viewState: state.viewState,
        child: Column(
          children: [_appBar(), SizedBox(height: 60.h), _bookPic(), SizedBox(height: 60.h), _search(), SizedBox(height: 60.h), AdsIssuesPage()],
        ));
  }

  Widget _bookPic() => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2.r, color: Colors.black),
          color: ColorX.primaryYellow,
        ),
        child: SvgPicture.asset(Assets.svgHomeBook, width: 0.388.sw),
      );

  Widget _appBar() => Container(
        width: 1.sw,
        padding: EdgeInsets.only(top: 60.h, bottom: 20.h),
        color: ColorX.primaryYellow,
        // child: SvgPicture.asset(
        //   Assets.svgHomeLogo,
        //   width: 42.w,
        //   height: 46.h,
        // ),
        height: 128.h,
      );

  Widget _search() => GestureDetector(
        onTap: () => Get.to(() => SearchResultPage()),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40.w),
          padding: EdgeInsets.all(34.r),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), border: Border.all(width: 1.r, color: Colors.black)),
          child: Row(
            children: [
              SvgPicture.asset(Assets.svgHomeSearch, width: 32.r, height: 32.r, color: Color(0xFF686868)),
              SizedBox(width: 40.w),
              TextX('Search for author, book title...', color: ColorX.txtDesc, fontSize: FontSizeX.s13)
            ],
          ),
        ),
      );
}
