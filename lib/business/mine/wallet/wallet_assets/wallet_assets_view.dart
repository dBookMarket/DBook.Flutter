import 'package:dbook/business/mine/wallet/wallet_assets/wallet_assets_state.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/avatar_widget.dart';
import 'package:dbook/common/widgets/line_widget.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/config/app_config.dart';
import '../../../../common/widgets/view_state/base_container_view.dart';
import 'wallet_assets_logic.dart';

class WalletAssetsPage extends StatelessWidget {
  WalletAssetsLogic get logic => Get.find<WalletAssetsLogic>();

  WalletAssetsState get state => Get.find<WalletAssetsLogic>().state;

  @override
  Widget build(BuildContext context) {
    Get.put(WalletAssetsLogic());

    return BaseContainer(
      background: Colors.transparent,
      child: _body(),
      retry: logic.getBalance,
      viewState: state.viewState,
    );
  }

  Widget _body() {
    return SmartRefresher(
      controller: state.refreshController,
      onRefresh: logic.refreshData,
      enablePullUp: false,
      child: SingleChildScrollView(
        child: _balance(),
      ),
    );
  }

  Widget _balance() => Column(children: [
        _header('FileCoin public chain'),
        Obx(() => _balanceItem(value: state.fileCoinBalance.value, icon: Assets.svgCoinFil, unit: 'FIL')),
        LineH(margin: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH)),
        Obx(() => _balanceItem(value: state.fileCoinTokenBalance.value, icon: Assets.svgCoinUsdc, unit: 'USDC-BEP20')),
        _header('Polygon public chain'),
        Obx(() => _balanceItem(value: state.polygonMainBalance.value, icon: Assets.svgCoinMatic, unit: 'MATIC')),
        LineH(margin: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH)),
        Obx(() => _balanceItem(value: state.polygonTokenBalance.value, icon: Assets.svgCoinUsdc, unit: 'USDC-ERC20')),
        _header('BSC public chain'),
        Obx(() => _balanceItem(value: state.bscMainBalance.value, icon: Assets.svgCoinBnb, unit: 'BNB')),
        LineH(margin: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH)),
        Obx(() => _balanceItem(value: state.bscTokenBalance.value, icon: Assets.svgCoinUsdc, unit: 'USDC-BEP20')),
      ]);

  Widget _header(String title) => Container(
        color: Color(0xFFFFF7EC),
        width: 1.sw,
        padding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 20.h),
        child: TextX(title, fontSize: FontSizeX.s13, color: Color(0xFF42392B), textAlign: TextAlign.start),
      );

  Widget _balanceItem({required String icon, required String value, required String unit}) => Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 20.h),
        child: Row(
          children: [
            AvatarX(icon, size: 70.r),
            SizedBox(width: 38.w),
            TextX(value + ' ' + unit, fontSize: FontSizeX.s13, color: Color(0xFF42392B)),
          ],
        ),
      );
}
