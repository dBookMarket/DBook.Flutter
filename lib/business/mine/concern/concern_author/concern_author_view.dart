import 'package:dbook/business/assets/assets_view.dart';
import 'package:dbook/common/entities/fans_entity.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/avatar_widget.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/config/app_config.dart';
import '../../../../common/widgets/view_state/base_container_view.dart';
import '../../../assets/assets_state.dart';
import 'concern_author_logic.dart';
import 'concern_author_state.dart';

class ConcernAuthorPage extends StatelessWidget {
  final tag = DateTime.now().toString();

  ConcernAuthorLogic get logic => Get.find<ConcernAuthorLogic>(tag: tag);

  ConcernAuthorState get state => Get.find<ConcernAuthorLogic>(tag: tag).refreshState;

  @override
  Widget build(BuildContext context) {
    Get.put(ConcernAuthorLogic(), tag: tag);
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
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 20.w,
          padding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 20.h),
          mainAxisSpacing: 20.w,
          children: state.list.map((element) => _item(element)).toList(),
        ),
      );
    });
  }

  Widget _item(FansEntity info) {
    var w = (1.sw - ScreenConfig.marginH * 3 - 40.w) / 3;

    return InkWell(
        onTap: () => _onClick(info),
        child: Container(
          width: w,
          height: w,
          // color: Colors.red,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            children: [
              AvatarX(info.author?.avatarUrl, size: w - 33.h - FontSizeX.s13),
              SizedBox(height: 13.h),
              TextX(info.author?.name, fontSize: FontSizeX.s13, color: ColorX.txtTitle)
            ],
          ),
        ));
  }

  _onClick(FansEntity param) {
    Get.to(() => AssetsPage(), arguments: {'title': 'Author Detail', 'assetsType': AssetsType.AUTHOR, 'userId': param.author?.id.toString()}, preventDuplicates: false);
  }
}
