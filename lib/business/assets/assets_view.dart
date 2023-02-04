import 'dart:ui';

import 'package:dbook/common/config/app_config.dart';
import 'package:dbook/common/store/store.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/avatar_widget.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../common/utils/string_helper.dart';
import '../../common/values/colors.dart';
import '../../common/values/fontSize.dart';
import 'assets_inner/assets_inner_view.dart';
import 'assets_logic.dart';
import 'assets_state.dart';

class AssetsPage extends StatelessWidget {
  final tag = DateTime.now().toString();

  AssetsLogic get logic => Get.find<AssetsLogic>(tag: tag);
  AssetsState get state => Get.find<AssetsLogic>(tag: tag).state;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsLogic(), tag: tag);
    return Stack(
      children: [
        _headerBg(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar(
              title: Get.arguments?['title'] ?? 'Books',
              backgroundColor: Colors.transparent,
              actions: [_action()],
              backColor: Colors.white,
              txtColor: Colors.white),
          body: body(),
        )
      ],
    );
  }

  Widget _action() => GestureDetector(
        child: Container(
          padding: EdgeInsets.only(right: ScreenConfig.marginH),
          child: SvgPicture.asset(
            Assets.svgShare,
            width: 50.r,
          ),
        ),
      );

  Widget body() => SingleChildScrollView(
        child: Column(
          children: [_userInfo(), _statistic(),AssetsInnerPage()],
        ),
      );

  Widget _headerBg() => Obx(() {
        if (UserStore.to.userInfo.bannerUrl == null || UserStore.to.userInfo.bannerUrl!.isEmpty) return SizedBox();
        return Stack(
          children: [
            Image.network(
              UserStore.to.userInfo.bannerUrl ?? '',
              width: 1.sw,
              height: 0.65.sw,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
                child: BackdropFilter(
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
              filter: ImageFilter.blur(sigmaX: 1.2, sigmaY: 1.2),
            ))
          ],
        );
      });

  Widget _userInfo() => Obx(() {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 15.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return AvatarX(
                  state.userInfo.value.avatarUrl,
                  size: 140.r,
                );
              }),
              SizedBox(width: 32.w),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Obx(() {
                        return TextX(state.userInfo.value.name, color: ColorX.txtWhite, fontSize: FontSizeX.s16);
                      }),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        margin: EdgeInsets.only(left: 20.h),
                        decoration:
                            BoxDecoration(color: ColorX.primaryYellow, borderRadius: BorderRadius.circular(100)),
                        child: TextX(formatAddress(state.userInfo.value.address),
                            fontSize: FontSizeX.s11, color: ColorX.txtBrown),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  SizedBox(height: 18.h),
                  Obx(() {
                    return TextX(
                      state.userInfo.value.desc,
                      fontSize: FontSizeX.s11,
                      color: ColorX.txtYellow,
                      maxLines: 3,
                      textAlign: TextAlign.start,
                    );
                  }),
                  SizedBox(height: 18.h),
                  Row(
                    children: [
                      TextX('read more',
                          style: TextStyle(
                              fontSize: FontSizeX.s11, decoration: TextDecoration.underline, color: ColorX.txtYellow)),
                      Expanded(child: SizedBox()),
                      SvgPicture.asset(Assets.svgLogoWeb, width: 40.r, height: 40.r),
                      SizedBox(width: 22.w),
                      SvgPicture.asset(Assets.svgLogoDiscord, width: 40.r, height: 40.r),
                      SizedBox(width: 22.w),
                      SvgPicture.asset(Assets.svgLogoTwitterBlack, width: 40.r, height: 40.r),
                    ],
                  )
                ],
              ))
            ],
          ),
        );
      });

  Widget _statistic() => Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r), boxShadow: [
          BoxShadow(
            color: Color(0xFFE4E4E4), //底色,阴影颜色
            offset: Offset(0, 0), //阴影位置,从什么位置开始
            blurRadius: 18, // 阴影模糊层度
            spreadRadius: 0,
          )
        ]),
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 34.h),
        margin: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 15.h),
        child: Obx(() {
          logX.d('经营数据>>>>${state.userInfo.value.statistic}');
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _statisticItem(title: 'Total volume', value: state.userInfo.value.statistic?.totalVolume ?? '0'),
                  SizedBox(height: 30.h),
                  _statisticItem(title: 'Count of books', value: state.userInfo.value.statistic?.totalBooks ?? '0'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _statisticItem(title: 'Upset', value: state.userInfo.value.statistic?.minPrice ?? '0'),
                  SizedBox(height: 30.h),
                  _statisticItem(title: 'Sales', value: state.userInfo.value.statistic?.sales ?? '0'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _statisticItem(title: 'Highest price', value: state.userInfo.value.statistic?.maxPrice ?? '0'),
                  SizedBox(height: 30.h),
                  _statisticItem(title: 'Owner', value: state.userInfo.value.statistic?.nOwners ?? '0'),
                ],
              ),
            ],
          );
        }),
      );

  Widget _statisticItem({required String title, required String value}) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextX(value, fontSize: FontSizeX.s15, color: ColorX.txtTitle),
        SizedBox(height: 16.h),
        TextX(title, fontSize: FontSizeX.s11, color: ColorX.txtHint),
      ]);
}
