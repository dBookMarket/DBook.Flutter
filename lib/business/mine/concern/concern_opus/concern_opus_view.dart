import 'package:dbook/common/entities/issues_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/config/app_config.dart';
import '../../../../common/entities/concern_opus_entity.dart';
import '../../../../common/values/colors.dart';
import '../../../../common/values/fontSize.dart';
import '../../../../common/widgets/avatar_widget.dart';
import '../../../../common/widgets/line_widget.dart';
import '../../../../common/widgets/text.dart';
import '../../../../common/widgets/view_state/base_container_view.dart';
import '../../../issues/issues_detail/issues_detail_view.dart';
import 'concern_opus_logic.dart';
import 'concern_opus_state.dart';

class ConcernOpusPage extends StatelessWidget {
  final tag = DateTime.now().toString();

  ConcernOpusLogic get logic => Get.find<ConcernOpusLogic>(tag: tag);

  ConcernOpusState get state => Get.find<ConcernOpusLogic>(tag: tag).refreshState;

  @override
  Widget build(BuildContext context) {
    Get.put(ConcernOpusLogic(), tag: tag);

    return BaseContainer(
      background: Colors.transparent,
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
            padding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 40.h),
            itemCount: state.list.length,
            itemBuilder: (ctx, index) {
              return _item(state.list[index]);
            }),
      );
    });
  }

  Widget _item(ConcernOpusEntity info) {
    return InkWell(
      onTap: () => _onClick(info),
      child: Column(
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
      ),
    );
  }

  Widget _author(ConcernOpusEntity info) => Row(children: [
        AvatarX(info.issue?.book?.author?.avatarUrl ?? '', size: 30.r),
        SizedBox(width: 12.w),
        TextX(
          info.issue?.book?.author?.name,
          fontSize: FontSizeX.s11,
          color: ColorX.txtHint,
        )
      ]);

  Widget _public(ConcernOpusEntity info) {
    var count = info.issue?.quantity ?? 0 - (info.issue?.nCirculations ?? 0);
    return Row(
      children: [
        _publicCountItem(t: 'Price', v: '${info.issue?.price.toString()}UDSC'),
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

  _onClick(ConcernOpusEntity param) {
    IssuesEntity detail = IssuesEntity.fromJson(param.issue?.toJson() ?? {});
    Get.to(() => IssuesDetailPage(), arguments: {'detail': detail});
  }
}
