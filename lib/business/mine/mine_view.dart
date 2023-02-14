import 'package:dbook/business/assets/assets_state.dart';
import 'package:dbook/business/mine/writing/view.dart';
import 'package:dbook/common/config/app_config.dart';
import 'package:dbook/common/store/user.dart';
import 'package:dbook/common/utils/string_helper.dart';
import 'package:dbook/common/values/colors.dart';
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

import '../assets/assets_view.dart';
import 'concern/concern_view.dart';
import 'create_book/create_book_view.dart';
import 'mine_logic.dart';
import 'profile_settings/profile_settings_view.dart';

class MinePage extends StatelessWidget {
  final logic = Get.put(MineLogic());
  final state = Get.find<MineLogic>().state;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
        viewState: state.viewState,
        child: Scaffold(
          appBar: appBar(
              title: 'Personal Center', canPop: false, backgroundColor: ColorX.primaryYellow, actions: [_action()]),
          body: _body(),
        ));
  }

  Widget _action() => GestureDetector(
        child: Container(
            child: SvgPicture.asset(Assets.svgCreateBook, width: 60.r, height: 60.r),
            margin: EdgeInsets.only(right: ScreenConfig.marginH)),
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
    return Obx(() {
      var name = UserStore.to.userInfo.name?.isEmpty ?? false ? 'No Name' : UserStore.to.userInfo.name;
      return Row(children: [
        SizedBox(width: ScreenConfig.marginH),
        Obx(() {
          return AvatarX(UserStore.to.userInfo.avatarUrl, size: 130.r);
        }),
        SizedBox(width: 50.w),
        UserStore.to.isLogin
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextX(name, fontSize: FontSizeX.s16, color: ColorX.txtBrown),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    margin: EdgeInsets.only(top: 20.h),
                    decoration: BoxDecoration(color: ColorX.primaryBrown, borderRadius: BorderRadius.circular(100)),
                    child: TextX(formatAddress(UserStore.to.userInfo.address),
                        fontSize: FontSizeX.s11, color: ColorX.txtYellow),
                  )
                ],
              )
            : TextX('Not logged in', fontSize: FontSizeX.s16, color: ColorX.txtBrown)
      ]);
    });
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
          _item(title: 'Asset', icon: Assets.svgMineAssets),
          LineH(margin: EdgeInsets.symmetric(horizontal: 12.w)),
          _item(title: 'Wallet activity', icon: Assets.svgMineWalletActivity),
          LineH(margin: EdgeInsets.symmetric(horizontal: 12.w)),
          _item(title: 'Concern', icon: Assets.svgMineConcern),
          LineH(margin: EdgeInsets.symmetric(horizontal: 12.w)),
          _item(title: 'Writing', icon: Assets.svgMineWriting),
          LineH(margin: EdgeInsets.symmetric(horizontal: 12.w)),
          _item(title: 'Publication management', icon: Assets.svgMinePublication),
          LineH(margin: EdgeInsets.symmetric(horizontal: 12.w)),
          _item(title: 'Earnings', icon: Assets.svgMineEarnings),
          LineH(margin: EdgeInsets.symmetric(horizontal: 12.w)),
          _item(title: 'Profile settings', icon: Assets.svgMineProfile),
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

  _onClick(String action) {
    switch (action) {
      case 'create':
        Get.to(() => CreateBookPage());
        break;
      case 'Asset':
        Get.to(() => AssetsPage(),arguments: {'title':'My Assets','assetsType':AssetsType.MY_ASSETS,'tabIndex':0},preventDuplicates:false);
        break;
      case 'Wallet activity':
        break;
      case 'Concern':
        Get.to(()=>ConcernPage());
        break;
      case 'Writing':
        Get.to(()=>WritingPage());
        break;
      case 'Publication management':
        Get.to(() => AssetsPage(),arguments: {'title':'My Assets','assetsType':AssetsType.MY_ASSETS,'tabIndex':1},preventDuplicates:false);
        break;
      case 'Earnings':
        Get.to(() => AssetsPage(),arguments: {'title':'My Assets','assetsType':AssetsType.MY_ASSETS,'tabIndex':3},preventDuplicates:false);
        break;
      case 'Profile settings':
        Get.to(() => ProfileSettingsPage());
        break;
    }
  }
}
