import 'package:dbook/business/assets/assets_inner/assets_earnings/state.dart';
import 'package:dbook/common/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/config/app_config.dart';
import '../../../../common/entities/transactions_list_entity.dart';
import '../../../../common/utils/string_helper.dart';
import '../../../../common/values/colors.dart';
import '../../../../common/values/fontSize.dart';
import '../../../../common/widgets/text.dart';
import '../../../../common/widgets/view_state/base_container_view.dart';
import '../../../../generated/assets.dart';
import '../../assets_state.dart';
import '../../assets_view.dart';
import 'logic.dart';

class AssetsEarningsPage extends StatelessWidget {
  final tag = DateTime.now().toString();

  AssetsEarningsLogic get logic => Get.find<AssetsEarningsLogic>(tag: tag);

  AssetsEarningsState get state => Get.find<AssetsEarningsLogic>(tag: tag).refreshState;


  @override
  Widget build(BuildContext context) {
    Get.put(AssetsEarningsLogic(), tag: tag);

    return BaseContainer(
      viewState: state.viewState,
      margin: EdgeInsets.only(top: 220.h),
      retry: logic.refresh,
      child: _table(),
    );
  }

  Widget _table() {
    return Obx(() {
      List tempList = state.list.toList();
      tempList.insert(0, TransactionsListEntity());
      return SmartRefresher(
        controller: state.refreshController,
        onRefresh: logic.refresh,
        onLoading: logic.loadMore,
        enablePullUp: state.canLoadMore,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 0.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                //列宽
                0: FixedColumnWidth(80),
                1: FixedColumnWidth(100.0),
                2: FixedColumnWidth(80.0),
                3: FixedColumnWidth(50.0),
                4: FixedColumnWidth(150.0),
                5: FixedColumnWidth(150.0),
                6: FixedColumnWidth(60.0),
                7: FixedColumnWidth(130.0),
                8: FixedColumnWidth(0),
              },
              children: tempList.asMap().keys.map((index) => _tableItem(tempList, index)).toList(),
            ),
          ),
        ),
      );
    });
  }

  TableRow _tableItem(var tempList, int index) {
    TransactionsListEntity item = tempList[index];
    if (index == 0) {
      return TableRow(children: [
        TextX('Event', fontSize: FontSizeX.s11, color: ColorX.txtHint),
        TextX('Book', fontSize: FontSizeX.s11, color: ColorX.txtHint),
        TextX('Unit Price', fontSize: FontSizeX.s11, color: ColorX.txtHint),
        TextX('Quantity', fontSize: FontSizeX.s11, color: ColorX.txtHint),
        TextX('From', fontSize: FontSizeX.s11, color: ColorX.txtHint),
        TextX('To', fontSize: FontSizeX.s11, color: ColorX.txtHint),
        TextX('Status', fontSize: FontSizeX.s11, color: ColorX.txtHint),
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
      TextX(formatAddress(item.issue?.book?.title), fontSize: FontSizeX.s11, color: ColorX.txtTitle),
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
      InkWell(child: _nameAndAddress(item.seller?.name,item.seller?.address),onTap: ()=>_onClick('from',param: item)),
      InkWell(child: _nameAndAddress(item.buyer?.name,item.buyer?.address),onTap: ()=>_onClick('to',param: item)),
      TextX(item.status, fontSize: FontSizeX.s11, color: ColorX.txtTitle),
      TextX(item.createdAt, fontSize: FontSizeX.s11, color: ColorX.txtTitle),
      SizedBox(height: 40.h)
    ]);
  }

  Widget _nameAndAddress(String? name,String? address){
    if(address == UserStore.to.userInfo.address){
      name = 'YouSelf';
    }

    if(name == null||name.isEmpty){
      return TextX(formatAddress(address), fontSize: FontSizeX.s11, color: ColorX.txtTitle);
    }else{
      return TextX('$name(${formatAddress(address)})', fontSize: FontSizeX.s11, color: ColorX.txtTitle);
    }
  }

  _onClick(type,{param}){
    switch(type){
      case 'from':
        var id = param.seller?.id;
        if(id == UserStore.to.userInfo.id) return;
        Get.to(() => AssetsPage(), arguments: {'title': 'Author Detail', 'assetsType': AssetsType.AUTHOR, 'userId': id.toString()}, preventDuplicates: false);
        break;
      case 'to':
        var id = param.buyer?.id;
        if(id == UserStore.to.userInfo.id) return;
        Get.to(() => AssetsPage(), arguments: {'title': 'Author Detail', 'assetsType': AssetsType.AUTHOR, 'userId': id.toString()}, preventDuplicates: false);
        break;
    }
  }
}
