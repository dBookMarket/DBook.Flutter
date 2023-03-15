import 'package:common_utils/common_utils.dart';
import 'package:dbook/business/mine/wallet/wallet_activity/wallet_activity_state.dart';
import 'package:dbook/common/store/order.dart';
import 'package:dbook/common/store/web3.dart';
import 'package:dbook/common/utils/string_helper.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:dbook/common/widgets/web_page/web_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/config/app_config.dart';
import '../../../../common/entities/transactions_list_entity.dart';
import '../../../../common/values/colors.dart';
import '../../../../common/values/fontSize.dart';
import '../../../../common/widgets/avatar_widget.dart';
import '../../../../common/widgets/line_widget.dart';
import '../../../../common/widgets/view_state/base_container_view.dart';
import 'wallet_activity_logic.dart';

class WalletActivityPage extends StatelessWidget {
  WalletActivityLogic get logic => Get.find<WalletActivityLogic>();

  WalletActivityState get state => Get.find<WalletActivityLogic>().refreshState;

  @override
  Widget build(BuildContext context) {
    Get.put(WalletActivityLogic());

    return state.needAppBar
        ? Scaffold(
            appBar: appBar(title: 'Activity'),
            body: BaseContainer(
              background: Colors.transparent,
              child: _list(),
              retry: logic.refresh,
              viewState: state.viewState,
            ),
          )
        : BaseContainer(
            background: Colors.transparent,
            child: _list(),
            retry: logic.refresh,
            viewState: state.viewState,
          );
  }

  Widget _list() {
    return Obx(() {
      return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 40.h),
          itemCount: OrderStore.to.orderList.length,
          itemBuilder: (ctx, index) {
            return _item(OrderStore.to.orderList[index]);
          });
    });
  }

  Widget _item(TransactionsListEntity info) => Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              width: 1.sw,
              height: 180.h,
              child: Row(
                children: [
                  Image.network(
                    info.issue?.book?.coverUrl ?? '',
                    height: 180.h,
                    width: 140.w,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 23.w),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AvatarX(info.issue?.book?.author?.avatarUrl ?? '', size: 30.r),
                          SizedBox(width: 12.w),
                          TextX(info.issue?.book?.author?.name, fontSize: FontSizeX.s11, color: ColorX.txtHint),
                          Spacer(),
                          TextX(
                            DateUtil.formatDate(DateUtil.getDateTime(info.createdAt!)),
                            color: ColorX.txtDesc,
                            fontSize: FontSizeX.s11,
                          )
                        ],
                      ),
                      SizedBox(height: 14.h),
                      TextX(
                        info.issue?.book?.title,
                        fontSize: FontSizeX.s15,
                        color: ColorX.txtTitle,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                      ),
                      Expanded(child: SizedBox()),
                      Row(children: [TextX('status: ${info.status}'), Spacer(), _hash(info)]),
                    ],
                  )),
                ],
              ),
            ),
            LineH(margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 50.h))
          ],
        ),
      );

  Widget _hash(info) => InkWell(
        onTap: () => _toScan(info),
        child: (info.hash?.isEmpty ?? true)
            ? SizedBox()
            : TextX('${formatAddress(info.hash)}',
                style: TextStyle(fontSize: FontSizeX.s13, color: ColorX.txtBrown, decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.solid, decorationColor: ColorX.txtBrown)),
      );

  _toScan(TransactionsListEntity info) {
    if(info.issue?.token?.blockChain == PublicChainType.bnb.name){
      Get.to(()=>WebPageView('Transaction', ScanConfig.bnb+info.hash!));
    }else if(info.issue?.token?.blockChain == PublicChainType.polygon.name){
      Get.to(()=>WebPageView('Transaction', ScanConfig.polygon+info.hash!));
    }else if(info.issue?.token?.blockChain == PublicChainType.filecoin.name){
      Get.to(()=>WebPageView('Message', ScanConfig.fileCoin+info.hash!));
    }

  }
}
