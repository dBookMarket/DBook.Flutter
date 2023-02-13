import 'package:dbook/business/assets/assets_inner/assets_draft/state.dart';
import 'package:dbook/common/config/app_config.dart';
import 'package:dbook/common/values/colors.dart';
import 'package:dbook/common/values/fontSize.dart';
import 'package:dbook/common/widgets/dialog.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/entities/drafts_entity.dart';
import '../../../../common/widgets/view_state/base_container_view.dart';
import '../../../../generated/assets.dart';
import '../../../mine/create_book/create_book_view.dart';
import '../../../mine/writing/view.dart';
import 'logic.dart';

class AssetsDraftPage extends StatelessWidget {
  final tag = DateTime.now().toString();

  AssetsDraftLogic get logic => Get.find<AssetsDraftLogic>(tag: tag);

  AssetsDraftState get state => Get.find<AssetsDraftLogic>(tag: tag).refreshState;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsDraftLogic(), tag: tag);
    return BaseContainer(
      background: Colors.transparent,
      child: _list(),
      margin: EdgeInsets.only(top: 220.h),
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
        child: GridView.count(
          crossAxisCount: 2,
          physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 20.w,
          padding: EdgeInsets.symmetric(horizontal:ScreenConfig.marginH,vertical: 20.h),
          mainAxisSpacing: 20.w,
          children: state.list.map((element) => _item(element)).toList(),
        ),
      );
    });
  }

  Widget _item(DraftsEntity info) {
    var w = (1.sw - ScreenConfig.marginH * 2 - 20.w) / 2;
    var h = w * 2.28;

    return Container(
      width: w,
      height: h,
      child: Row(
        children: [Expanded(child: _cover(info.title)), SizedBox(width: 10.w), _action(info)],
      ),
    );
  }

  Widget _cover(title) => Container(
      width: 1.sw,
      alignment: Alignment.bottomCenter,
      color: Color(0xFFEAC38A),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(Assets.svgBookDraft, width: 55.w),
          SizedBox(height: 20.h),
          TextX(title, fontSize: FontSizeX.s11, color: ColorX.txtBrown),
          SizedBox(height: 48.h)
        ],
      ));

  Widget _action(DraftsEntity info) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _button(icon: Assets.svgDraftModify, title: 'Edit', info: info),
        _button(icon: Assets.svgDraftPublish, title: 'Push', info: info),
        _button(icon: Assets.svgDraftDelete, title: 'Delete', fontSize: FontSizeX.s9, info: info),
      ]);

  Widget _button({Color? bgColor, Color? txtColor, required String icon, required String title, double? fontSize, DraftsEntity? info}) => InkWell(
        onTap: () => _onClick(title, param: info),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: bgColor ?? ColorX.buttonYellow),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          margin: EdgeInsets.only(bottom: 10.h),
          child: Row(
            children: [SvgPicture.asset(icon, width: 26.w), TextX(title, fontSize: fontSize ?? FontSizeX.s11, color: txtColor ?? ColorX.txtTitle)],
          ),
        ),
      );

  _onClick(type, {param}) async {
    switch (type) {
      case 'Edit':
        await Get.to(() => WritingPage(), arguments: {'draftInfo': param});
        logic.refresh();
        break;
      case 'Push':
        await Get.to(() => CreateBookPage(), arguments: {'draftId': param.id});
        logic.refresh();
        break;
      case 'Delete':
        Get.dialog(DialogX(
          title: 'warning',
          content: 'Are you sure you want to delete it?',
          left: 'cancel',
          right: 'OK',
          rightCallback: () => logic.delete(param.id),
        ));
        break;
    }
  }
}
