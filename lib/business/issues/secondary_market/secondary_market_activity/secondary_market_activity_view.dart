import 'package:dbook/common/utils/string_helper.dart';
import 'package:dbook/common/values/values.dart';
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
      child: _table(),
    );
  }

  Widget _table() {
    List tempList = state.list.value.toList();
    tempList.insert(0, TransactionsListEntity());
    return SmartRefresher(
      controller: state.refreshController,
      onRefresh: logic.refresh,
      onLoading: logic.loadMore,
      enablePullUp: state.canLoadMore,
      enablePullDown: true,
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              //列宽
              0: FixedColumnWidth(80),
              1: FixedColumnWidth(100.0),
              2: FixedColumnWidth(80.0),
              3: FixedColumnWidth(80.0),
              4: FixedColumnWidth(100.0),
              5: FixedColumnWidth(100.0),
              6: FixedColumnWidth(130.0),
              7: FixedColumnWidth(0),
            },
            children: tempList.asMap().keys.map((index) => _tableItem(tempList,index)).toList(),
          ),
        ),
      ),
    );
  }

  TableRow _tableItem(var tempList,int index) {
    TransactionsListEntity item = tempList[index];
    if (index == 0) {
      return TableRow(children: [
        TextX('Event', fontSize: FontSizeX.s11, color: ColorX.txtHint),
        TextX('Hash', fontSize: FontSizeX.s11, color: ColorX.txtHint),
        TextX('Unit Price', fontSize: FontSizeX.s11, color: ColorX.txtHint),
        TextX('Quantity', fontSize: FontSizeX.s11, color: ColorX.txtHint),
        TextX('From', fontSize: FontSizeX.s11, color: ColorX.txtHint),
        TextX('To', fontSize: FontSizeX.s11, color: ColorX.txtHint),
        TextX('Date', fontSize: FontSizeX.s11, color: ColorX.txtHint),
        SizedBox(height: 60.h)
      ]);
    }

    return TableRow(children: [
      SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(item.xSource == 1 ? Assets.svgIssuesDetailPublish : Assets.svgIssuesDetailTrade,
                width: 30.w, color: item.xSource == 1 ? ColorX.primaryYellow : Color(0xFFD06969)),
            SizedBox(width: 10.w),
            TextX(item.xSource == 1 ? 'Starting' : 'Trading ', fontSize: FontSizeX.s11, color: ColorX.txtTitle),
          ],
        ),
      ),




      TextX(formatAddress(item.hash), fontSize: FontSizeX.s11, color: ColorX.txtTitle),
      SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.svgIssuesDetailCoin, width: 30.w, color: ColorX.primaryYellow),
            SizedBox(width: 10.w),
            TextX(item.price.toString(), fontSize: FontSizeX.s11, color: ColorX.txtTitle),
          ],
        ),
      ),
      TextX(item.quantity.toString(), fontSize: FontSizeX.s11, color: ColorX.txtTitle),
      TextX(formatAddress(item.buyer?.address), fontSize: FontSizeX.s11, color: ColorX.txtTitle),
      TextX(formatAddress(item.seller?.address), fontSize: FontSizeX.s11, color: ColorX.txtTitle),
      TextX(item.createdAt, fontSize: FontSizeX.s11, color: ColorX.txtTitle),
      SizedBox(height: 40.h)
    ]);
  }
}
