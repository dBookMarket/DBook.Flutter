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

import '../../common/utils/loading.dart';
import 'assets_logic.dart';

class AssetsPage extends StatelessWidget {
  final logic = Get.put(AssetsLogic());
  final state = Get.find<AssetsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appbar(),
      body: SizedBox(
        height: 1.sh,
        child: Column(
          children: [
            SizedBox(
              height: 63.h,
            ),
            _appbar(),
            Expanded(child: _list())
          ],
        ),
      ),
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
            _menuItem(ImageConstants.copy, '复制地址'),
            _menuItem(ImageConstants.toggle, '切换账户'),
            _menuItem(ImageConstants.disconnect, '断开连接'),
          ];
        },
      );

  PopupMenuItem _menuItem(String image, String txt) => PopupMenuItem(
        // padding: EdgeInsets.zero,
        onTap: () => _onClick(txt),
        child: Container(
          constraints: BoxConstraints(maxWidth: 200.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
          child: GridView.count(
            shrinkWrap: true,
            //水平子Widget之间间距
            crossAxisSpacing: 40.w,
            //垂直子Widget之间间距
            mainAxisSpacing: 40.h,
            //一行的Widget数量
            crossAxisCount: 2,
            //子Widget宽高比例
            childAspectRatio: 0.825,
            //子Widget列表
            children: state.list.map((item) => _item(item)).toList(),
          ),
        );
      }),
    );
  }

  Widget _item(AssetsEntity item) {
    return Container(
      child: Row(
        children: [
          ImageHelper.network(item.issue?.cover, width: 164.w, height: 205.h),
          SizedBox(width: 35.w),
          Column(
            children: [
              TextX(
                item.issue?.name,
                maxLines: 2,
                color: ColorX.txtTitle,
                fontSize: 26.sp,
              ),
              SizedBox(height: 26.h),
              Container(
                decoration: BoxDecoration(color: Color(0xFFE1E1E1), borderRadius: BorderRadius.circular(5.r)),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: TextX(
                  item.issue?.authorName,
                  fontSize: 19.sp,
                  color: ColorX.txtHint,
                ),
              ),
              Row(
                children: [ImageX(ImageConstants.tag, width: 17.w, height: 24.h), SizedBox(width: 12.w), TextX('阅读标签：${item.issue?.nPages}/${item.amount}')],
              )
            ],
          )
        ],
      ),
    );
  }

  _onClick(event) async {
    switch (event) {
      case '复制地址':
        Clipboard.setData(ClipboardData(text: Web3KeychainManager.getInstance().addresses()[0].hex));
        showSuccess(t: '复制成功！');
        break;
      case '断开连接':
      case '切换账户':
        disconnect();
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
    if (result.isNotEmpty) {
      await Web3KeychainManager.getInstance().remove(Web3KeychainManager.getInstance().addresses()[0], result);
      await UserStore.to.onLogout();
    }
  }
}
