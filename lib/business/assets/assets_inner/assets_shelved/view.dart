import 'package:dbook/business/assets/assets_inner/assets_shelved/state.dart';
import 'package:dbook/common/values/colors.dart';
import 'package:dbook/common/values/fontSize.dart';
import 'package:dbook/common/widgets/avatar_widget.dart';
import 'package:dbook/common/widgets/line_widget.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/config/app_config.dart';
import '../../../../common/entities/issues_entity.dart';
import '../../../../common/widgets/dialog.dart';
import '../../../../common/widgets/view_state/base_container_view.dart';
import '../../asset_publish/asset_publish_view.dart';
import 'logic.dart';

class AssetsShelvedPage extends StatelessWidget {
  final tag = DateTime.now().toString();

  AssetsShelvedLogic get logic => Get.find<AssetsShelvedLogic>(tag: tag);

  AssetsShelvedState get state => Get.find<AssetsShelvedLogic>(tag: tag).refreshState;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsShelvedLogic(), tag: tag);

    return BaseContainer(
      background: Colors.transparent,
      child: _list(),
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
            padding: EdgeInsets.symmetric(horizontal:ScreenConfig.marginH,vertical: 20.h),
            itemCount: state.list.length,
            itemBuilder: (ctx, index) {
              return _item(state.list[index]);
            }),
      );
    });
  }

  Widget _item(IssuesEntity info) {
    return Column(
      children: [
        Container(
            height: 180.h,
            width: 1.sw,
            child: Row(
              children: [
                Image.network(info.book?.coverUrl ?? '', width: 140.w, height: 180.h, fit: BoxFit.cover),
                SizedBox(width: 20.w),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _author(info),
                    SizedBox(height: 20.h),
                    TextX(info.book?.title, color: ColorX.txtTitle, fontSize: FontSizeX.s16, maxLines: 2, textAlign: TextAlign.start),
                    Expanded(child: SizedBox()),
                    _public(info)
                  ],
                ))
              ],
            )),
        SizedBox(height: 30.h),
        _action(info),
        LineH(
          margin: EdgeInsets.only(top: 20.h),
          height: 1.r,
          color: ColorX.divider,
        )
      ],
    );
  }

  Widget _author(IssuesEntity info) => Row(children: [
        AvatarX(info.book?.author?.avatarUrl ?? '', size: 30.r),
        SizedBox(width: 12.w),
        TextX(
          info.book?.author?.name,
          fontSize: FontSizeX.s11,
          color: ColorX.txtHint,
        )
      ]);

  Widget _public(IssuesEntity info) {
    var count = info.quantity ?? 0 - (info.nCirculations ?? 0);
    return Row(
      children: [
        _publicCountItem(t: 'Floor price', v: '${info.priceRange?.minPrice.toString()}UDSC'),
        _publicCountItem(t: 'Circulation', v: info.nCirculations.toString()),
        _publicCountItem(t: 'Destruction', v: count.toString()),
      ],
    );
  }

  Widget _publicCountItem({required String t, required String v}) => Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextX(t, fontSize: FontSizeX.s11, color: ColorX.txtHint),
          SizedBox(height: 10.h),
          TextX(v, fontSize: FontSizeX.s13, color: ColorX.txtTitle),
        ],
      ));

  Widget _action(info) => Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        _button(icon: Assets.svgIssueTakeDown, title: 'Take Down',info:info),
        SizedBox(width: 18.w),
        _button(icon: Assets.svgIssueEdit, title: 'Revise', bgColor: Color(0XFFFFB4B4),info:info),
      ]);

  Widget _button({Color? bgColor, Color? txtColor, required String icon, required String title, double? fontSize, info}) => InkWell(
        onTap: () => _onClick(title, param: info),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.r), color: bgColor ?? ColorX.buttonYellow),
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
          margin: EdgeInsets.only(bottom: 10.h),
          child: Row(
            children: [SvgPicture.asset(icon, width: 26.w), SizedBox(width: 12.w), TextX(title, fontSize: fontSize ?? FontSizeX.s11, color: txtColor ?? ColorX.txtTitle)],
          ),
        ),
      );

  _onClick(type, {IssuesEntity? param}) async{
    switch (type) {
      case 'Take Down':
        Get.dialog(DialogX(
          title: 'warning',
          content: 'Are you sure you want to take down it?',
          left: 'cancel',
          right: 'OK',
          rightCallback: () => logic.delete(param?.id),
        ));
        break;
      case 'Revise':
        await Get.to(() => AssetPublishPage(), arguments: {'issueInfo': param});
        logic.refresh();
        break;
    }
  }
}
