import 'package:dbook/business/assets/assets_inner/assets_pending_orders/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/config/app_config.dart';
import '../../../../common/entities/issues_entity.dart';
import '../../../../common/entities/pending_order_entity.dart';
import '../../../../common/values/colors.dart';
import '../../../../common/values/fontSize.dart';
import '../../../../common/widgets/dialog.dart';
import '../../../../common/widgets/text.dart';
import '../../../../common/widgets/view_state/base_container_view.dart';
import '../../../../generated/assets.dart';
import '../../../issues/issues_detail/issues_detail_view.dart';
import '../../assets_sell/assets_sell_view.dart';
import 'logic.dart';

class AssetsPendingOrdersPage extends StatelessWidget {
  final tag = DateTime.now().toString();
  AssetsPendingOrdersLogic get logic => Get.find<AssetsPendingOrdersLogic>(tag: tag);
  AssetsPendingOrdersState get state => Get.find<AssetsPendingOrdersLogic>(tag: tag).refreshState;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsPendingOrdersLogic(),tag: tag);

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
          padding: EdgeInsets.symmetric(horizontal:ScreenConfig.marginH,vertical: 20.h),
          mainAxisSpacing: 20.w,
          childAspectRatio: 0.8,
          children: state.list.map((element) => _item(element)).toList(),
        ),
      );
    });
  }

  Widget _item(PendingOrderEntity info) {
    var w = (1.sw - ScreenConfig.marginH * 2 - 20.w) / 2;
    // var h = w * 2.28+40.h;

    return Container(
      width: w,
      // height: h,
      child: InkWell(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Expanded(child: Image.network(info.issue?.book?.coverUrl??'',fit: BoxFit.cover,height: w,)), SizedBox(width: 10.w), _action(info)],
          ),
          SizedBox(height: 20.h),
          TextX(info.issue?.book?.title, fontSize: FontSizeX.s11, color: ColorX.txtBrown,textAlign: TextAlign.start),
        ],),onTap:()=>_onClick('detail',param: info))
    );
  }

  Widget _action(PendingOrderEntity info) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _button(icon: Assets.svgIssueRead, title: 'Cancel', info: info),
    _button(icon: Assets.svgIssueSell, title: 'Edit', info: info),
  ]);

  Widget _button({Color? bgColor, Color? txtColor, required String icon, required String title, double? fontSize, PendingOrderEntity? info}) => InkWell(
    onTap: () => _onClick(title, param: info),
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: bgColor ?? ColorX.buttonYellow),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [SvgPicture.asset(icon, width: 26.w), TextX(title, fontSize: fontSize ?? FontSizeX.s11, color: txtColor ?? ColorX.txtTitle)],
      ),
    ),
  );

  _onClick(type, {PendingOrderEntity? param}) async {
    switch (type) {
      case 'Edit':
        var result = await Get.to(() => AssetsSellPage(), arguments: {'issueId': param?.issue?.id,'price':param?.price.toString(),'quantity':param?.quantity,'tradeId':param?.id},opaque: false);
        if (result != null) {
          logic.refresh();
        }
        break;
      case 'Cancel':
        Get.dialog(DialogX(
          title: 'warning',
          content: 'Are you sure you want to Cancel it?',
          left: 'Cancel',
          right: 'OK',
          rightCallback: () => logic.delete(param?.id),
        ));
        break;

      case 'detail':
        IssuesEntity detail = IssuesEntity.fromJson(param?.issue?.toJson() ?? {});
        Get.to(() => IssuesDetailPage(), arguments: {'detail': detail});
        break;
    }
  }
}
