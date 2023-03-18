import 'package:dbook/business/assets/assets_inner/assets_shelved/state.dart';
import 'package:dbook/business/issues/issue_item/issue_item.dart';
import 'package:dbook/common/values/colors.dart';
import 'package:dbook/common/values/fontSize.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/entities/issues_entity.dart';
import '../../../../common/widgets/dialog.dart';
import '../../../../common/widgets/view_state/base_container_view.dart';
import '../../../issues/issues_detail/issues_detail_view.dart';
import '../../../issues/issues_state.dart';
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
        child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            itemCount: state.list.length,
            itemBuilder: (ctx, index) {
              return _item(state.list[index]);
            }),
      );
    });
  }

  Widget _item(IssuesEntity item) => Column(children: [
        IssuesItemView(item, action: _action(item)),
      ]);

  Widget _action(info) {
    if(info.status == IssuesStatus.on_sale.name||info.status == IssuesStatus.off_sale.name){
      return SizedBox();
    }
    return Container(
        margin: EdgeInsets.only(right: 40.w, top: 50.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          _button(icon: Assets.svgIssueTakeDown, title: 'Delisting', info: info),
          SizedBox(width: 18.w),
          _button(icon: Assets.svgIssueEdit, title: 'Relist', bgColor: Color(0XFFFFB4B4), info: info),
        ]));
  }

  Widget _button({Color? bgColor, Color? txtColor, required String icon, required String title, double? fontSize, info}) => InkWell(
        onTap: () => _onClick(title, param: info),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.r), color: bgColor ?? ColorX.buttonYellow),
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
          // margin: EdgeInsets.only(bottom: 10.h),
          child: Row(
            children: [SvgPicture.asset(icon, width: 26.w), SizedBox(width: 12.w), TextX(title, fontSize: fontSize ?? FontSizeX.s11, color: txtColor ?? ColorX.txtTitle)],
          ),
        ),
      );

  _onClick(type, {IssuesEntity? param}) async {
    switch (type) {
      case 'Delisting':
        Get.dialog(DialogX(
          title: 'warning',
          content: 'Are you sure you want to delisting it?',
          left: 'cancel',
          right: 'OK',
          rightCallback: () => logic.delete(param?.id),
        ));
        break;
      case 'Relist':
        await Get.to(() => AssetPublishPage(), arguments: {'issueInfo': param});
        logic.refresh();
        break;
      case 'detail':
        Get.to(() => IssuesDetailPage(), arguments: {'detail': param});
        break;
    }
  }
}
