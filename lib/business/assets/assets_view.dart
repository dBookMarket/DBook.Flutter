import 'package:dbook/business/asset_detail/asset_detail_view.dart';
import 'package:dbook/business/login/verify_password/verify_password_view.dart';
import 'package:dbook/common/entities/assets_entity.dart';
import 'package:dbook/common/key_manager/keystore_manager.dart';
import 'package:dbook/common/store/store.dart';
import 'package:dbook/common/utils/image_helper.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:dbook/common/values/colors.dart';
import 'package:dbook/common/values/images.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/entities/assets_info_entity.dart';
import '../../common/utils/loading.dart';
import 'assets_logic.dart';

class AssetsPage extends StatelessWidget {
  final logic = Get.put(AssetsLogic());
  final state = Get.find<AssetsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appbar(),
      body: OrientationBuilder(builder: (c,o)=>SizedBox(
        height: 1.sh,
        child: Column(
          children: [
            SizedBox(
              height: 63.h,
            ),
            _appbar(),
            SizedBox(height: 20.h),
            Expanded(child: _list())
          ],
        ),
      ),),
    );
  }

  Widget _appbar() => Row(
        children: [SizedBox(width: 30.w), ImageX(ImageConstants.dBook, width: 250.w), Expanded(child: SizedBox()), _action(), SizedBox(width: 30.w)],
      );

  Widget _action() => PopupMenuButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 33.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: ColorX.primaryMain,
            borderRadius: BorderRadius.circular(100),
          ),
          constraints: BoxConstraints(maxWidth: 200.w),
          child: TextX(
            Web3KeychainManager().addresses()[0].hex,
            color: Colors.white,
            fontSize: 26.sp,
          ),
        ),
        offset: Offset(20.w, 60.h),
        color: ColorX.primaryMain,
        itemBuilder: (BuildContext context) {
          return [
            _menuItem(ImageConstants.copy, 'Copy'),
            _menuItem(ImageConstants.toggle, 'Switch'),
            _menuItem(ImageConstants.disconnect, 'Disconnect'),
          ];
        },
      );

  PopupMenuItem _menuItem(String image, String txt) => PopupMenuItem(
        // padding: EdgeInsets.zero,
        onTap: () => _onClick(txt),
        child: Container(
          constraints: BoxConstraints(maxWidth: 150.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [ImageX(image, width: 25.r, height: 25.r), SizedBox(width: 27.w), TextX(txt, color: Colors.white, fontSize: 26.sp)],
          ),
        ),
        value: txt,
      );

  Widget _list() {
    return Container(
      child: Obx(() {
        return SmartRefresher(
          controller: state.refreshController,
          onRefresh: logic.refresh,
          // onLoading: logic.loadMore,
          // enablePullUp: state.canLoadMore,
          enablePullDown: true,
          child: ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (ctx, index) {
                return _item(state.list[index]);
              }),
        );
      }),
    );
  }

  Widget _item(AssetsInfoResults item) {
    return GestureDetector(child: Container(
      padding: EdgeInsets.symmetric(horizontal: 42.w, vertical: 25.h),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: ImageHelper.network(item.issue?.coverUrl, width: 164.w, height: 205.h),
            borderRadius: BorderRadius.circular(12.r),
          ),
          SizedBox(width: 35.w),
          Expanded(
              child: Container(
                height: 205.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextX(
                      item.issue?.name,
                      maxLines: 2,
                      color: ColorX.txtTitle,
                      textAlign: TextAlign.start,
                      fontSize: 26.sp,
                    ),
                    // SizedBox(height: 26.h),
                    Container(
                      decoration: BoxDecoration(color: Color(0xFFE1E1E1), borderRadius: BorderRadius.circular(5.r)),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: TextX(
                        item.issue?.authorName,
                        fontSize: 19.sp,
                        color: ColorX.txtHint,
                      ),
                    ),
                    // SizedBox(height: 20.h),
                    Row(
                      children: [
                        ImageX(ImageConstants.tag, width: 17.w, height: 24.h),
                        SizedBox(width: 12.w),
                        TextX(
                          'mark：${item.bookmark?.currentPage}/${item.issue?.nPages}',
                          fontSize: 19.sp,
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    ),onTap: ()=>_onClick('进入详情',param: item.id),);
  }

  _onClick(event,{param}) async {
    switch (event) {
      case 'Copy':
        Clipboard.setData(ClipboardData(text: Web3KeychainManager.getInstance().addresses()[0].hex));
        showSuccess(t: 'Copy succeeded！');
        break;
      case 'Disconnect':
      case 'Switch':
        disconnect();
        break;
      case '进入详情':
        Get.to(()=>AssetDetailPage(),arguments: Map.of({'id':param}));
        break;
    }
  }

  disconnect() async {
    // Get.back();
    await Future.delayed(Duration(milliseconds: 200));
    var result = await Get.dialog(
        VerifyPasswordPage(
          verifyType: VerifyType.verifyPassword,
        ),
        barrierDismissible: false);
    if (result != null && result.isNotEmpty) {
      await Web3KeychainManager.getInstance().remove(Web3KeychainManager.getInstance().addresses()[0], result);
      await UserStore.to.onLogout();
    }
  }
}
