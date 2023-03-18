import 'package:dbook/business/assets/assets_state.dart';
import 'package:dbook/common/config/app_config.dart';
import 'package:dbook/common/store/user.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:dbook/common/utils/string_helper.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/avatar_widget.dart';
import 'package:dbook/common/widgets/line_widget.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/routes/names.dart';
import '../../common/store/overlay.dart';
import 'mine_logic.dart';

class MinePage extends StatelessWidget {
  final logic = Get.put(MineLogic());
  final state = Get.find<MineLogic>().state;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
        viewState: state.viewState,
        child: Scaffold(
          appBar: appBar(title: 'My account', canPop: false, backgroundColor: ColorX.primaryYellow, actions: [_action()]),
          body: _body(),
        ));
  }

  Widget _action() => GestureDetector(
        child: Container(child: SvgPicture.asset(Assets.svgCreateBook, width: 60.r, height: 60.r), margin: EdgeInsets.only(right: ScreenConfig.marginH)),
        onTap: () => _onClick('create'),
      );

  Widget _body() => Stack(children: [_headerBg(), _content()]);

  Widget _headerBg() => Container(
        width: 1.sw,
        height: 432.h,
        color: ColorX.primaryYellow,
      );

  Widget _content() => SingleChildScrollView(
        child: Column(children: [_userInfo(), _list()]),
      );

  Widget _userInfo() {
    return InkWell(
      onTap: () => _onClick('Account settings'),
      child: Obx(() {
        var name = UserStore.to.userInfo.name?.isEmpty ?? false ? formatAddress(UserStore.to.userInfo.address) : UserStore.to.userInfo.name;
        return Row(children: [
          SizedBox(width: ScreenConfig.marginH),
          Obx(() {
            return AvatarX(UserStore.to.userInfo.avatarUrl, size: 130.r);
          }),
          SizedBox(width: 50.w),
          UserStore.to.isLogin
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  TextX(name, fontSize: FontSizeX.s16, color: ColorX.txtBrown),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    margin: EdgeInsets.only(top: 20.h),
                    decoration: BoxDecoration(color: ColorX.primaryBrown, borderRadius: BorderRadius.circular(100)),
                    child: TextX(formatAddress(UserStore.to.userInfo.address), fontSize: FontSizeX.s11, color: ColorX.txtYellow),
                  )
                ])
              : TextX(
                  'Not logged in',
                  style: TextStyle(
                    fontSize: FontSizeX.s16,
                    color: ColorX.txtBrown,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor:Colors.red,
                    decorationThickness: 1,
                  ),
                )
        ]);
      }),
    );
  }

  Widget _list() => Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r), boxShadow: [
          BoxShadow(
            color: ColorX.shadow, //底色,阴影颜色
            offset: Offset(0, 0), //阴影位置,从什么位置开始
            blurRadius: 18, // 阴影模糊层度
            spreadRadius: 0,
          )
        ]),
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 45.h),
        child: Column(children: [
          _item(title: 'Wallet assets', icon: Assets.svgMineAssets),
          LineH(margin: EdgeInsets.symmetric(horizontal: 12.w)),
          _item(title: 'Wallet activity', icon: Assets.svgMineWalletActivity),
          LineH(margin: EdgeInsets.symmetric(horizontal: 12.w)),
          _item(title: 'Watchlist', icon: Assets.svgMineConcern),
          LineH(margin: EdgeInsets.symmetric(horizontal: 12.w)),
          _item(title: 'Writing', icon: Assets.svgMineWriting),
          LineH(margin: EdgeInsets.symmetric(horizontal: 12.w)),
          _item(title: 'Draft', icon: Assets.svgMineHistory),
          LineH(margin: EdgeInsets.symmetric(horizontal: 12.w)),
          _item(title: 'Unlisted', icon: Assets.svgMinePublication),
          LineH(margin: EdgeInsets.symmetric(horizontal: 12.w)),
          _item(title: 'Earnings', icon: Assets.svgMineEarnings),
          LineH(margin: EdgeInsets.symmetric(horizontal: 12.w)),
          _item(title: 'Settings', icon: Assets.svgMineProfile),
          // LineH(margin: EdgeInsets.symmetric(horizontal: 12.w)),
          // _item(title: 'test', icon: Assets.svgMineProfile),
        ]),
      );

  Widget _item({required String icon, required String title}) => GestureDetector(
        onTap: () => _onClick(title),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 60.w, right: 40.w, top: 40.h, bottom: 40.h),
          child: Row(
            children: [
              SvgPicture.asset(icon, height: 40.r),
              SizedBox(width: 44.w),
              TextX(title, fontSize: FontSizeX.s13, color: ColorX.txtTitle),
              Expanded(child: SizedBox()),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
      );

  _onClick(String action) async {
    switch (action) {
      case 'create':
        Get.toNamed(AppRoutes.CreateBook);
        break;
      case 'Wallet assets':
        Get.toNamed(AppRoutes.Wallet, arguments: {'index': 0});
        break;
      case 'Wallet activity':
        Get.toNamed(AppRoutes.Wallet, arguments: {'index': 1});
        break;
      case 'Watchlist':
        Get.toNamed(AppRoutes.Concern);
        break;
      case 'Writing':
        Get.toNamed(AppRoutes.Writing);
        break;
      case 'Draft':
        Get.toNamed(AppRoutes.Assets, arguments: {'title': 'Author', 'assetsType': AssetsType.MY_ASSETS, 'tabIndex': 0}, preventDuplicates: false);
        break;
      case 'Unlisted':
        Get.toNamed(AppRoutes.Assets, arguments: {'title': 'Author', 'assetsType': AssetsType.MY_ASSETS, 'tabIndex': 1}, preventDuplicates: false);
        break;
      case 'Earnings':
        Get.toNamed(AppRoutes.Assets, arguments: {'title': 'Author', 'assetsType': AssetsType.MY_ASSETS, 'tabIndex': 3}, preventDuplicates: false);
        break;
      case 'Settings':
        Get.toNamed(AppRoutes.ProfileSettings);
        break;
      case 'Account settings':
        Get.toNamed(AppRoutes.AccountSetting);
        break;
      case 'test':
        logX.d('show>>>>');
        // OverlayToolWrapper.of(Get.context!).showFloating();
        OverlayStore.to.showFloating();
        // var result = await Get.to(()=>BuyAuthorizePage(),arguments: {'chainType':PublicChainType.polygon,'from':UserStore.to.address,'to':UserStore.to.address,'amount':1,'price':10.0});
        // logX.d('result>>>>$result');
        break;
    }
  }
}
