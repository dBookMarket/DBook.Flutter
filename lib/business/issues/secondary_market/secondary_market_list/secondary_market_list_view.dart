import 'package:dbook/business/issues/issue_buy/issue_buy_view.dart';
import 'package:dbook/common/store/store.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/avatar_widget.dart';
import 'package:dbook/common/widgets/button.dart';
import 'package:dbook/common/widgets/line_widget.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/entities/trades_list_entity.dart';
import '../../../../common/utils/string_helper.dart';
import '../../../../common/widgets/view_state/base_container_view.dart';
import '../../../login/guide/view.dart';
import 'secondary_market_list_logic.dart';

class SecondaryMarketListPage extends StatelessWidget {
  final logic = Get.put(SecondaryMarketListLogic());
  final state = Get.find<SecondaryMarketListLogic>().refreshState;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      viewState: state.viewState,
      retry: logic.refresh,
      child: _list(),
    );
  }

  Widget _list() {
    return Obx(() {
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
    });
  }

  Widget _item(TradesListEntity info) => Container(
        width: 1.sw,
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Row(
              children: [
                SizedBox(width: 25.w),
                AvatarX(
                  info.user?.avatarUrl,
                  size: 58.r,
                ),
                SizedBox(width: 28.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextX(formatAddress(info.user?.address), fontSize: FontSizeX.s13, color: ColorX.txtTitle),
                    SizedBox(height: 4.h),
                    TextX(info.createdAt, fontSize: FontSizeX.s13, color: ColorX.txtHint),
                  ],
                ),
                Expanded(child: SizedBox()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextX('${info.price}USDC', fontSize: FontSizeX.s13, color: ColorX.txtTitle),
                    SizedBox(height: 10.h),
                    _buyButton(info)
                  ],
                ),
                SizedBox(width: 25.w),
              ],
            ),
            SizedBox(height: 10.h),
            LineH()
          ],
        ),
      );

  Widget _buyButton(TradesListEntity info){
    var buttonValid = info.user?.id != UserStore.to.userInfo.id;
    if(!buttonValid){
      return SizedBox();
    }
    return ButtonX(
      'Buy',
      autoWidth: true,
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
      borderRadius: 0,
      backgroundColor: Colors.green,
      fontSize: FontSizeX.s13,
      onPressed: () => _onClick(info),
    );
  }


  _onClick(TradesListEntity info){
    if (!UserStore.to.isLogin) {
      Get.to(() => GuidePage());
      return;
    }
    logX.d('chainType:${state.issuesInfo.token?.blockChain}');
    Get.to(()=>IssueBuyPage(),opaque: false,arguments: {'tradeDetail':info},duration: Duration(milliseconds: 0),fullscreenDialog: true);
  }
}
