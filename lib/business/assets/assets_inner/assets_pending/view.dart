import 'package:dbook/business/assets/assets_inner/assets_pending/state.dart';
import 'package:dbook/common/entities/book_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/config/app_config.dart';
import '../../../../common/values/colors.dart';
import '../../../../common/values/fontSize.dart';
import '../../../../common/widgets/dialog.dart';
import '../../../../common/widgets/text.dart';
import '../../../../common/widgets/view_state/base_container_view.dart';
import '../../../../generated/assets.dart';
import '../../../mine/create_book/create_book_view.dart';
import '../../asset_publish/asset_publish_view.dart';
import 'logic.dart';

class AssetsPendingPage extends StatelessWidget {
  final tag = DateTime.now().toString();

  AssetsPendingLogic get logic => Get.find<AssetsPendingLogic>(tag: tag);

  AssetsPendingState get state => Get.find<AssetsPendingLogic>(tag: tag).refreshState;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsPendingLogic(), tag: tag);
    return BaseContainer(
      background: Colors.transparent,
      margin: EdgeInsets.only(top: 220.h),
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
        child: GridView.count(
          crossAxisCount: 2,
          physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 20.w,
          padding: EdgeInsets.symmetric(horizontal:ScreenConfig.marginH,vertical: 20.h),
          mainAxisSpacing: 20.w,
          childAspectRatio: 0.9,
          children: state.list.map((element) => _item(element)).toList(),
        ),
      );
    });
  }

  Widget _item(BookEntity info) {
    var w = (1.sw - ScreenConfig.marginH * 2 - 20.w) / 2;
    var h = w * 2.28;

    return Container(
      width: w,
      height: h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Expanded(child: Image.network(info.coverUrl ?? '', fit: BoxFit.cover, height: h)), SizedBox(width: 10.w), _action(info)],
          )),
          SizedBox(height: 10.h),
          TextX(info.title,maxLines: 2,textAlign: TextAlign.start,color: ColorX.txtDesc)

        ],
      ),
    );
  }


  Widget _action(info) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _button(icon: Assets.svgDraftModify, title: 'Edit', info: info),
        _button(icon: Assets.svgDraftPublish, title: 'Push', info: info),
        _button(icon: Assets.svgDraftDelete, title: 'Delete', fontSize: FontSizeX.s9, info: info),
      ]);

  Widget _button({Color? bgColor, Color? txtColor, required String icon, required String title, double? fontSize, info}) => InkWell(
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
        await Get.to(() => CreateBookPage(), arguments: {'bookInfo': param});
        logic.refresh();
        break;
      case 'Push':
        await Get.to(() => AssetPublishPage(), arguments: {'bookInfo': param});
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
