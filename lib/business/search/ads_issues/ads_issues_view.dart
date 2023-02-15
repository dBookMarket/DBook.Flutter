import 'package:carousel_slider/carousel_slider.dart';
import 'package:dbook/common/entities/ads_issue_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/config/app_config.dart';
import '../../../common/entities/issues_entity.dart';
import '../../../common/values/colors.dart';
import '../../../common/widgets/view_state/base_container_view.dart';
import '../../issues/issues_detail/issues_detail_view.dart';
import 'ads_issues_logic.dart';

class AdsIssuesPage extends StatelessWidget {
  final logic = Get.put(AdsIssuesLogic());
  final state = Get.find<AdsIssuesLogic>().state;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
        viewState: state.viewState,
        emptyView: SizedBox(),
        child: Container(
          padding: EdgeInsets.only(top: 18.h, left: ScreenConfig.marginH, right: ScreenConfig.marginH, bottom: 30.h),
          child: Stack(
            children: [
              Obx(() => _banner()),
              Obx(() => state.list.length > 1
                  ? Positioned(
                child: Obx(() => _indicator()),
                bottom: 25.h,
              ): SizedBox()),
            ],
          ),
        ));
  }

  Widget _banner() {
    if (state.list.length == 0) return SizedBox();
    return CarouselSlider(
        items: state.list.map((element) => _bannerItem(element)).toList(),
        options: CarouselOptions(
            height: 390 / 678 * (1.sw - ScreenConfig.marginH * 2),
            viewportFraction: 1,
            enableInfiniteScroll: state.list.length > 1,
            autoPlay: state.list.length > 1,
            enlargeCenterPage: true,
            autoPlayInterval: Duration(seconds: 4),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            onPageChanged: (index, _) => state.currentIndex = index,
            scrollDirection: Axis.horizontal)
            // pageViewKey: PageStorageKey<String>(HOME_BANNER_INDEX))
    );
  }

  Widget _bannerItem(AdsIssueEntity item) {
    return GestureDetector(
      onTap: () => _onClick(item),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: Image.network(item.issue?.book?.coverUrl??'', width: 1.sw, fit: BoxFit.cover),
      ),
    );
  }

  Widget _indicator() {
    return Container(
      width: 1.sw - (ScreenConfig.marginH * 2),
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        spacing: 16.w,
        children: state.list.asMap().keys.map((index) => _indicatorItem(index)).toList(),
      ),
    );
  }

  Widget _indicatorItem(index) {
    return Container(
      width: 16.r,
      height: 16.r,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: state.currentIndex == index ? ColorX.indicatorSelected : ColorX.indicatorUnSelect),
    );
  }

  _onClick(AdsIssueEntity param) {
    IssuesEntity detail = IssuesEntity.fromJson(param.issue?.toJson() ?? {});
    Get.to(() => IssuesDetailPage(), arguments: {'detail': detail});
  }
}
