import 'package:dbook/business/mine/wallet/wallet_activity/wallet_activity_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/config/app_config.dart';
import '../../../../common/widgets/view_state/base_container_view.dart';
import 'wallet_activity_logic.dart';

class WalletActivityPage extends StatelessWidget {
  WalletActivityLogic get logic => Get.find<WalletActivityLogic>();
  WalletActivityState get state => Get.find<WalletActivityLogic>().refreshState;

  @override
  Widget build(BuildContext context) {
    Get.put(WalletActivityLogic());

    return BaseContainer(
      background: Colors.transparent,
      child: _list(),
      retry: logic.refresh,
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
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 40.h),
            itemCount: state.list.length,
            itemBuilder: (ctx, index) {
              return _item(state.list[index]);
            }),
      );
    });
  }

  Widget _item(info) {
    return Container();
  }

}
