import 'dart:ui';

import 'package:dbook/business/mine/profile_settings/twitterShare/twitter_share_view.dart';
import 'package:dbook/common/config/app_config.dart';
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
import '../../common/widgets/web_page/web_page_view.dart';
import 'assets_logic.dart';
import 'assets_state.dart';

class AssetsPage extends StatelessWidget {
  final tag = DateTime.now().toString();

  AssetsLogic get logic => Get.find<AssetsLogic>(tag: tag);

  AssetsState get state => Get.find<AssetsLogic>(tag: tag).state;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsLogic(), tag: tag);
    return _body();
  }

  Widget _body() => Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: _silverBuilder,
          body: TabBarView(
            children: state.pages,
            physics: NeverScrollableScrollPhysics(),
            controller: state.tabController,
          ),
        ),
      );

  List<Widget> _silverBuilder(BuildContext context, bool innerBoxIsScrolled) => [
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: Obx(() {
            return SliverAppBar(
                leading: state.assetsType == AssetsType.MY_BOOKS ? SizedBox() : appBarLeading(onTap: () => Get.back()),
                elevation: 0,
                // automaticallyImplyLeading: false,
                title: appBarTitle(title: Get.arguments?['title'] ?? 'My collection'),
                centerTitle: true,
                expandedHeight: state.flexibleSpaceH.value,
                floating: false,
                actions: _action(),
                pinned: true,
                bottom: _sliverBottom(),
                // backgroundColor: Colors.transparent,
                flexibleSpace: _flexibleSpace());
          }),
        ),
      ];

  PreferredSizeWidget _sliverBottom() => PreferredSize(
      child: Container(
        color: Color(0xFFFFF7EC),
        margin: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH),
        child: TabBar(
          controller: state.tabController,
          tabs: state.filter
              .map((e) => Tab(
                    text: e,
                    height: 64.h,
                  ))
              .toList(),
          labelPadding: EdgeInsets.symmetric(horizontal: 20.w),
          indicatorWeight: 1.h,
          indicatorPadding: EdgeInsets.only(
            bottom: 1.h,
          ),
          indicatorColor: Color(0xFF42392B),
          // indicator: UnderlineTabIndicatorX(insets: EdgeInsets.only(left: 50.w, right: 50.w, bottom: 20.h, top: 20.h), borderSide: BorderSide(width: 10.h, color: ColorX.selected)),
          labelColor: Color(0xFF42392B),
          unselectedLabelColor: Color(0xFF98866E),
          labelStyle: TextStyle(fontSize: FontSizeX.s13),
          unselectedLabelStyle: TextStyle(fontSize: FontSizeX.s13),
        ),
      ),
      preferredSize: Size(double.infinity, 64.h));

  List<Widget> _action() => [_share(), _collect()];

  Widget _share() => GestureDetector(
        onTap: () => _onClick('share'),
        child: Container(
          padding: EdgeInsets.only(right: ScreenConfig.marginH / 2),
          child: SvgPicture.asset(
            Assets.svgShare,
            width: 50.r,
          ),
        ),
      );

  Widget _collect() {
    if (state.assetsType != AssetsType.AUTHOR) return SizedBox();
    return GestureDetector(
      onTap: () => _onClick('collect'),
      child: Container(
        padding: EdgeInsets.only(right: ScreenConfig.marginH),
        child: Obx(() {
          return SvgPicture.asset(
            (state.userInfo.value.isFans ?? false) ? Assets.svgCollectUnselect : Assets.svgCollectUnselect,
            width: 50.r,
          );
        }),
      ),
    );
  }

  Widget _headerBg() {
    return Obx(() {
      var img = Image.network(
        state.userInfo.value.bannerUrl ?? '',
        width: 1.sw,
        height: 0.65.sw,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      );
      var defaultImg = Image.asset(
        Assets.imagesDefaultBookCover,
        width: 1.sw,
        height: 0.65.sw,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      );
      return Stack(
        children: [
          defaultImg,
          (state.userInfo.value.bannerUrl == null || state.userInfo.value.bannerUrl!.isEmpty) ? SizedBox() : img,
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
  }

  Widget _flexibleSpace() => FlexibleSpaceBar(
        background: new Container(
          child: new Stack(
            children: [
              _headerBg(),
              Column(
                children: [SizedBox(height: ScreenConfig.appBarHeight + ScreenUtil().statusBarHeight), _userInfo(), _statistic(), _flexTag()],
              )
            ],
          ),
        ),
      );

  Widget _flexTag() => Container(key: state.flexibleSpaceKey, width: 1.sw, height: 1.h);

  Widget _userInfo() => Obx(() {
        var name = state.userInfo.value.name?.isEmpty ?? false ? formatAddress(state.userInfo.value.address) : state.userInfo.value.name;
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
                      TextX(name, color: ColorX.txtWhite, fontSize: FontSizeX.s16),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        margin: EdgeInsets.only(left: 20.h),
                        decoration: BoxDecoration(color: ColorX.primaryYellow, borderRadius: BorderRadius.circular(100)),
                        child: TextX(formatAddress(state.userInfo.value.address), fontSize: FontSizeX.s11, color: ColorX.txtBrown),
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
                      maxLines: state.desLine.value,
                      textAlign: TextAlign.start,
                    );
                  }),
                  SizedBox(height: 18.h),
                  Row(
                    children: [
                      state.userInfo.value.desc?.isEmpty??false?SizedBox():GestureDetector(child: TextX('read more', style: TextStyle(fontSize: FontSizeX.s11, decoration: TextDecoration.underline, color: ColorX.txtYellow)),onTap: ()=>logic.readMore(),),
                      Expanded(child: SizedBox()),
                      _websiteBox(Assets.svgLogoWeb, 'website', state.userInfo.value.websiteUrl ?? ''),
                      _websiteBox(Assets.svgLogoDiscord, 'discord', state.userInfo.value.discordUrl ?? ''),
                      _websiteBox(Assets.svgLogoTwitterBlack, 'twitter', state.userInfo.value.twitterUrl ?? ''),
                    ],
                  )
                ],
              ))
            ],
          ),
        );
      });

  Widget _websiteBox(String svg, String title, value) {
    if (value == null || value.isEmpty) return SizedBox();
    return Container(
      child: InkWell(
        onTap: () => _onClick(title, param: value),
        child: SvgPicture.asset(svg, width: 40.r, height: 40.r),
      ),
      margin: EdgeInsets.only(right: 22.w),
    );
  }

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
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _statisticItem(title: 'Total volume', value: state.userInfo.value.statistic?.totalVolume ?? '0'),
                  SizedBox(height: 30.h),
                  _statisticItem(title: 'Total issuance', value: state.userInfo.value.statistic?.totalBooks ?? '0'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _statisticItem(title: 'Floor price', value: state.userInfo.value.statistic?.minPrice ?? '0'),
                  SizedBox(height: 30.h),
                  _statisticItem(title: 'Burn', value: state.userInfo.value.statistic?.nDestroyed ?? '0'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _statisticItem(title: 'Best price', value: state.userInfo.value.statistic?.maxPrice ?? '0'),
                  SizedBox(height: 30.h),
                  _statisticItem(title: 'Owner', value: state.userInfo.value.statistic?.nOwners ?? '0'),
                ],
              ),
            ],
          );
        }),
      );

  Widget _statisticItem({required String title, required String value}) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextX(value, fontSize: FontSizeX.s15, color: ColorX.txtTitle),
        SizedBox(height: 16.h),
        TextX(title, fontSize: FontSizeX.s11, color: ColorX.txtHint),
      ]);

  _onClick(type, {param}) {
    switch (type) {
      case 'collect':
        logic.collect();
        break;
      case 'website':
        Get.to(() => WebPageView(state.userInfo.value.name ?? '', param));
        break;
      case 'discord':
        Get.to(() => WebPageView(state.userInfo.value.name ?? '', param));
        break;
      case 'twitter':
        Get.to(() => WebPageView(state.userInfo.value.name ?? '', param));
        break;
      case 'share':
        Get.to(() => TwitterShareView(authorName: state.userInfo.value.name ?? '', authorId: state.userInfo.value.id.toString()));
        break;
    }
  }
}
