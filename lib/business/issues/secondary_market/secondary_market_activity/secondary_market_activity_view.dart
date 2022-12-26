import 'package:dbook/common/config/app_config.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:dbook/common/utils/string_helper.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/line_widget.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/entities/transactions_list_entity.dart';
import '../../../../common/widgets/view_state/base_container_view.dart';
import 'secondary_market_activity_logic.dart';

class SecondaryMarketActivityPage extends StatelessWidget {
  final logic = Get.put(SecondaryMarketActivityLogic());
  final state = Get.find<SecondaryMarketActivityLogic>().refreshState;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      viewState: state.viewState,
      retry: logic.refresh,
      emptyView: _noData(),
      child: _list(),
    );
  }

  Widget _noData() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(Assets.svgIssuesDetailNoData, width: 50.w),
      SizedBox(height: 20.h),
      TextX('no data', color: ColorX.txtHint),
    ],
  );
  Widget _list() {
    return Column(
      children: [
        _header(),
        LineH(),
        Expanded(child: Obx(() {
          return SmartRefresher(
            controller: state.refreshController,
            onRefresh: logic.refresh,
            onLoading: logic.loadMore,
            enablePullUp: state.canLoadMore,
            enablePullDown: true,
            child: ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (ctx, index) {
                  return _item(state.list[index]);
                }),
          );
        }))
      ],
    );
  }

  Widget _header() => Container(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: ScreenConfig.marginH),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextX('Event', fontSize: FontSizeX.s11, color: ColorX.txtHint),
          TextX('Book', fontSize: FontSizeX.s11, color: ColorX.txtHint),
          TextX('Unit Price', fontSize: FontSizeX.s11, color: ColorX.txtHint),
        ],
      ));

  Widget _item(TransactionsListEntity item) => Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: ScreenConfig.marginH),
        child: Row(
          children: [
            SvgPicture.asset(item.xSource == 1 ? Assets.svgIssuesDetailPublish : Assets.svgIssuesDetailTrade,
                width: 30.w, color: item.xSource == 1 ? ColorX.primaryYellow : Color(0xFFD06969)),
            SizedBox(width: 10.w),
            TextX(item.xSource == 1 ? 'Starting' : 'Trading ', fontSize: FontSizeX.s11, color: ColorX.txtTitle),
            Expanded(child: SizedBox()),
            TextX(formatAddress(item.hash), fontSize: FontSizeX.s11, color: ColorX.txtTitle),
            Expanded(child: SizedBox()),
            SizedBox(width: 10.w),
            SvgPicture.asset(Assets.svgIssuesDetailCoin, width: 30.w, color: ColorX.primaryYellow),
            SizedBox(width: 10.w),
            TextX(item.price.toString(), fontSize: FontSizeX.s11, color: ColorX.txtTitle),
          ],
        ),
      );
}
