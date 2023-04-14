import 'package:dbook/common/config/app_config.dart';
import 'package:dbook/common/store/user.dart';
import 'package:dbook/common/utils/string_helper.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/avatar_widget.dart';
import 'package:dbook/common/widgets/line_widget.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../common/utils/loading.dart';
import '../../../common/widgets/appBar.dart';
import '../../../common/widgets/button.dart';
import '../../../generated/assets.dart';
import 'account_setting_logic.dart';
import 'change_password/change_password_view.dart';

class AccountSettingPage extends StatelessWidget {
  final logic = Get.put(AccountSettingLogic());
  final state = Get
      .find<AccountSettingLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Profile settings'),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 24.h),
      child: Column(children: [_userInfo(), SizedBox(height: 40.h), _action(), Spacer(), _version(), _quitButton()]),
    );
  }

  Widget _userInfo() =>
      Row(children: [
        AvatarX(UserStore.to.userInfo.avatarUrl, size: 130.r),
        Spacer(),
        TextX(formatAddress(UserStore.to.userInfo.address), color: ColorX.txtTitle, fontSize: FontSizeX.s16),
        SizedBox(width: 40.w),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 26.h),
            child: SvgPicture.asset(Assets.svgCopy, width: 20.r),
          ),
          onTap: () => _onClick('copy', param: UserStore.to.address),
        )
      ]);

  Widget _action() =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                  color: ColorX.shadow, //底色,阴影颜色
                  offset: Offset(0, 0), //阴影位置,从什么位置开始
                  blurRadius: 18.r, // 阴影模糊层度
                  spreadRadius: 1 // 阴影扩散程度
              )
            ],
            color: Colors.white),
        child: Column(
          children: [
            _actionItem('Change the password'),
            LineH(),
            _actionItem('Switch accounts'),
          ],
        ),
      );

  Widget _actionItem(String title) =>
      InkWell(
        onTap: () => _onClick(title),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 30.h),
          child: Row(children: [TextX(title, color: ColorX.txtTitle, fontSize: FontSizeX.s16), Spacer(), Icon(Icons.chevron_right)]),
        ),
      );

  Widget _version() =>
      Container(
        width: 1.sw,
        margin: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 30.h),
        child: Obx(() {
          return TextX('v${state.versionName.value}', color: ColorX.txtHint, fontSize: FontSizeX.s13);
        }),
      );

  Widget _quitButton() => ButtonX('Quit', borderRadius: 0, margin: EdgeInsets.only(bottom: 46.h), onPressed: () => _onClick('quit'));

  _onClick(action, {param}) async {
    switch (action) {
      case 'copy':
        Clipboard.setData(ClipboardData(text: param));
        showSuccess(t: 'copy successfully');
        break;
      case 'quit':
      case 'Switch accounts':
        Get.back();
        UserStore.to.onLogout();
        break;
      case 'Change the password':
        Get.to(() => ChangePasswordPage());
        break;
    }
  }
}
