import 'package:dbook/business/assets/assets_inner/assets_my_collection/state.dart';
import 'package:dbook/business/assets/assets_sell/assets_sell_view.dart';
import 'package:dbook/business/issues/issues_state.dart';
import 'package:dbook/common/entities/collection_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/config/app_config.dart';
import '../../../../common/entities/issues_entity.dart';
import '../../../../common/values/colors.dart';
import '../../../../common/values/fontSize.dart';
import '../../../../common/widgets/text.dart';
import '../../../../common/widgets/view_state/base_container_view.dart';
import '../../../../generated/assets.dart';
import '../../../asset_detail/asset_detail_view.dart';
import '../../../issues/issues_detail/issues_detail_view.dart';
import 'logic.dart';

class AssetsMyCollectionPage extends StatelessWidget {
  final tag = DateTime.now().toString();

  AssetsMyCollectionLogic get logic => Get.find<AssetsMyCollectionLogic>(tag: tag);

  AssetsMyCollectionState get state => Get.find<AssetsMyCollectionLogic>(tag: tag).refreshState;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsMyCollectionLogic(), tag: tag);

    return BaseContainer(
      background: Colors.transparent,
      child: _list(),
      retry: logic.refresh,
      margin: EdgeInsets.only(top: 220.h),
      viewState: state.viewState,
    );
  }

  Widget _list() {
    return Obx(() {
      return SmartRefresher(
        controller: state.refreshController,
        onRefresh: logic.refresh,
        onLoading: logic.loadMore,
        enablePullUp: state.canLoadMore,
        child: GridView.count(
          crossAxisCount: 2,
          physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 20.w,
          padding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 20.h),
          mainAxisSpacing: 20.w,
          childAspectRatio: 0.8,
          children: state.list.map((element) => _item(element)).toList(),
        ),
      );
    });
  }

  Widget _item(CollectionEntity info) {
    var w = (1.sw - ScreenConfig.marginH * 2 - 20.w) / 2;
    // var h = w * 2.28+40.h;

    return Container(
      width: w,
      // height: h,
      child: InkWell(
        onTap: () => _onClick('detail', param: info),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Image.network(
                  info.issue?.book?.coverUrl ?? '',
                  fit: BoxFit.cover,
                  height: w,
                )),
                SizedBox(width: 10.w),
                _action(info)
              ],
            ),
            SizedBox(height: 20.h),
            TextX(info.issue?.book?.title, fontSize: FontSizeX.s11, color: ColorX.txtBrown, textAlign: TextAlign.start),
          ],
        ),
      ),
    );
  }

  Widget _action(CollectionEntity info) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _button(icon: Assets.svgIssueRead, title: 'Read', info: info),
        _button(icon: Assets.svgIssueSell, title: 'Sell', info: info),
      ]);

  Widget _button(
          {Color? bgColor,
          Color? txtColor,
          required String icon,
          required String title,
          double? fontSize,
          CollectionEntity? info}) =>
      InkWell(
        onTap: () => _onClick(title, param: info),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: bgColor ?? ColorX.buttonYellow),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          margin: EdgeInsets.only(bottom: 10.h),
          child: Row(
            children: [
              SvgPicture.asset(icon, width: 26.w),
              TextX(title, fontSize: fontSize ?? FontSizeX.s11, color: txtColor ?? ColorX.txtTitle)
            ],
          ),
        ),
      );


  _onClick(type, {CollectionEntity? param}) async {
    switch (type) {
      case 'Read':
        Get.to(() => AssetDetailPage(), arguments: {'assetId':param?.id});
        break;
      case 'Sell':
        if (param?.issue?.status != IssuesStatus.off_sale.name) {
          Get.snackbar('warning', 'Please wait for the data to be processed');
          return;
        }

        var result = await Get.to(() => AssetsSellPage(), arguments: {'issueId': param?.issue?.id},opaque: false,duration: Duration(milliseconds: 0),fullscreenDialog: true);
        if (result != null) {
          logic.refresh();
        }
        break;
      case 'detail':
        IssuesEntity detail = IssuesEntity.fromJson(param?.issue?.toJson() ?? {});
        Get.to(() => IssuesDetailPage(), arguments: {'detail': detail});
        break;
    }
  }
}
