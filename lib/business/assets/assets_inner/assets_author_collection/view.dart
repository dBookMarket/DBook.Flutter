import 'package:dbook/business/assets/assets_inner/assets_author_collection/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/config/app_config.dart';
import '../../../../common/entities/collection_entity.dart';
import '../../../../common/values/colors.dart';
import '../../../../common/values/fontSize.dart';
import '../../../../common/widgets/avatar_widget.dart';
import '../../../../common/widgets/line_widget.dart';
import '../../../../common/widgets/text.dart';
import '../../../../common/widgets/view_state/base_container_view.dart';
import 'logic.dart';

class AssetsAuthorCollectionPage extends StatelessWidget {
  final tag = DateTime.now().toString();
  AssetsAuthorCollectionLogic get logic => Get.find<AssetsAuthorCollectionLogic>(tag: tag);
  AssetsAuthorCollectionState get state => Get.find<AssetsAuthorCollectionLogic>(tag: tag).refreshState;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsAuthorCollectionLogic(), tag: tag);

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
            padding: EdgeInsets.symmetric(horizontal:ScreenConfig.marginH,vertical: 20.h),
            itemCount: state.list.length,
            itemBuilder: (ctx, index) {
              return _item(state.list[index]);
            }),
      );
    });
  }

  Widget _item(CollectionEntity info) {
    return Column(
      children: [
        Container(
            height: 180.h,
            width: 1.sw,
            child: Row(
              children: [
                Image.network(info.issue?.book?.coverUrl ?? '', width: 140.w, height: 180.h, fit: BoxFit.cover),
                SizedBox(width: 20.w),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _author(info),
                        SizedBox(height: 20.h),
                        TextX(info.issue?.book?.title, color: ColorX.txtTitle, fontSize: FontSizeX.s16, maxLines: 2, textAlign: TextAlign.start),
                        Expanded(child: SizedBox()),
                        _public(info)
                      ],
                    ))
              ],
            )),
        LineH(
          margin: EdgeInsets.symmetric(vertical: 20.h),
          height: 1.r,
          color: ColorX.divider,
        )
      ],
    );
  }

  Widget _author(CollectionEntity info) => Row(children: [
    AvatarX(info.issue?.book?.author?.avatarUrl ?? '', size: 30.r),
    SizedBox(width: 12.w),
    TextX(
      info.issue?.book?.author?.name,
      fontSize: FontSizeX.s11,
      color: ColorX.txtHint,
    )
  ]);

  Widget _public(CollectionEntity info) {
    var count = info.quantity ?? 0 - (info.issue?.nCirculations ?? 0);
    return Row(
      children: [
        _publicCountItem(t: 'Floor price', v: '${info.issue?.price.toString()}UDSC'),
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

  _onClick(type, {CollectionEntity? param}) async{
    switch (type) {
      case 'Take Down':

        break;
      case 'Revise':
        break;
    }
  }
}
