import 'dart:ui';

import 'package:dbook/common/config/app_config.dart';
import 'package:dbook/common/store/user.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/avatar_widget.dart';
import 'package:dbook/common/widgets/button.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../common/utils/loading.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fontSize.dart';
import '../../../common/widgets/dialog.dart';
import '../../../common/widgets/text.dart';
import 'profile_settings_logic.dart';

class ProfileSettingsPage extends StatelessWidget {
  final logic = Get.put(ProfileSettingsLogic());
  final state = Get
      .find<ProfileSettingsLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Profile settings'),
      body: BaseContainer(
        viewState: state.viewState,
        child: _body(),
      ),
    );
  }

  Widget _body() =>
      SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _avatar(),
            _twitter(),
            _bannerSelect(),
            // _item(title: 'Banners', controller: state.bannerController),
            _item(title: 'User name', controller: state.nameController, hint: ''),
            _item(title: 'Description', controller: state.descController, maxLines: 3, hint: 'Introduce yourself...'),

            _item(title: 'Site', controller: state.siteController, hint: 'https://'),
            _item(title: 'Discord community', controller: state.discordController, hint: 'https://'),
            _address(),
            _commitButton()
          ],
        ),
      );

  Widget _avatar() =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextX('Avatar', fontSize: FontSizeX.s13, color: ColorX.txtTitle),
        GestureDetector(
          onTap: () => _onClick('avatar'),
          child: Obx(() {
            if (state.avatar.value == null) {
              return AvatarX(UserStore.to.userInfo.avatarUrl, size: 90.r);
            }
            return ClipRRect(
              child: Image.file(state.avatar.value!, width: 90.r, height: 90.r, fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(100),
            );
          }),
        )
      ]);

  Widget _bannerSelect() {
    var w = 1.sw - ScreenConfig.marginH * 2;
    var h = (1.sw - ScreenConfig.marginH * 2) * 0.59;
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextX('Banner', color: ColorX.txtTitle, fontSize: FontSizeX.s13),
          SizedBox(height: 30.h),
          GestureDetector(
            onTap: () => _onClick('banner'),
            child: Container(
              width: w,
              height: h,
              decoration: BoxDecoration(border: Border.all(width: 1.r, color: ColorX.txtTitle)),
              child: Obx(() {
                if (state.banner.value != null) {
                  return Image.file(state.banner.value!, fit: BoxFit.cover, alignment: Alignment.topCenter, width: w, height: h);
                }
                if (UserStore.to.userInfo.bannerUrl != null && UserStore.to.userInfo.bannerUrl!.isNotEmpty) {
                  return Image.network(UserStore.to.userInfo.bannerUrl!, width: w, height: h, fit: BoxFit.cover, alignment: Alignment.topCenter);
                }
                return Icon(
                  Icons.add,
                  size: 100.r,
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget _commitButton() =>
      Obx(() {
        return ButtonX(
          'Commit',
          margin: EdgeInsets.only(top: 60.h),
          backgroundColor: state.buttonValid.value ? Color(0xFF42392B) : ColorX.buttonInValid,
          borderRadius: 0,
          textColor: state.buttonValid.value ? ColorX.txtYellow : ColorX.txtHint,
          fontSize: FontSizeX.s13,
          enable: state.buttonValid.value,
          padding: EdgeInsets.symmetric(vertical: 28.h),
          onPressed: () => _onClick('commit'),
        );
      });

  Widget _twitter() =>
      Container(
        margin: EdgeInsets.only(top: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextX('Authentication', color: ColorX.txtTitle, fontSize: FontSizeX.s13),
                Expanded(child: SizedBox()),
                SvgPicture.asset(Assets.svgLogoTwitter, width: 30.w),
                TextX(
                  'Twitter',
                  fontSize: FontSizeX.s13,
                  color: ColorX.txtDesc,
                ),
                SizedBox(width: 40.w),
                ButtonX(
                  'Go',
                  autoWidth: true,
                  backgroundColor: Color(0xFF42392B),
                  borderRadius: 0,
                  textColor: ColorX.txtYellow,
                  fontSize: FontSizeX.s13,
                  padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 40.w),
                  onPressed: () => _onClick('twitter'),
                )
              ],
            ),
            _twitterAddress()
          ],
        ),
      );

  Widget _twitterAddress() {
    return Obx(() {
      if (!(UserStore.to.userInfo.isVerified ?? false)) return SizedBox();
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        margin: EdgeInsets.only(top: 15.h),
        decoration: BoxDecoration(
          color: Color(0xFFFFF7EC),
          border: Border.all(width: 1.r, color: ColorX.txtTitle),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: TextX(UserStore.to.userInfo.twitterUrl, fontSize: FontSizeX.s11, color: ColorX.txtTitle, textAlign: TextAlign.start)),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 26.h),
                child: SvgPicture.asset(Assets.svgCopy, width: 20.r),
              ),
              onTap: () => _onClick('copy', param: UserStore.to.userInfo.twitterUrl),
            )
          ],
        ),
      );
    });
  }

  Widget _tag(String title, {double? marginTop}) =>
      Container(
        child: TextX(title, color: ColorX.txtTitle, fontSize: FontSizeX.s13),
        margin: EdgeInsets.only(top: marginTop ?? 30.h, bottom: 15.h),
      );

  Widget _item({required String title, required TextEditingController controller, String? hint, int? maxLines}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_tag(title), _textField(controller: controller, hint: hint, maxLines: maxLines)],
      );

  Widget _textField({required TextEditingController controller, String? hint, int? maxLines}) =>
      TextField(
        maxLines: maxLines ?? 1,
        maxLength: 300,
        textAlignVertical: TextAlignVertical.bottom,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: FontSizeX.s11, color: ColorX.txtTitle),
        controller: controller,
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 24.h),
          fillColor: Colors.white,
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xFF999999), fontSize: FontSizeX.s11),
          counterText: '',
          enabledBorder: OutlineInputBorder(
            /*边角*/
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: ColorX.txtTitle,
              width: 1.r,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            /*边角*/
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: ColorX.txtTitle,
              width: 1.r,
            ),
          ),
          border: OutlineInputBorder(
            /*边角*/
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: ColorX.txtTitle,
              width: 1.r,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorX.txtTitle,
              width: 1.r,
            ),
            borderRadius: BorderRadius.zero,
          ),
        ),
      );

  Widget _address() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tag('Wallet address'),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            decoration: BoxDecoration(
              color: Color(0xFFFFF7EC),
              border: Border.all(width: 1.r, color: ColorX.txtTitle),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: TextX(UserStore.to.address, fontSize: FontSizeX.s11, color: ColorX.txtTitle, textAlign: TextAlign.start)),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 26.h),
                    child: SvgPicture.asset(Assets.svgCopy, width: 20.r),
                  ),
                  onTap: () => _onClick('copy', param: UserStore.to.address),
                )
              ],
            ),
          )
        ],
      );

  _onClick(action, {param}) async {
    switch (action) {
      case 'copy':
        Clipboard.setData(ClipboardData(text: param));
        showSuccess(t: 'copy successfully');
        break;
      case 'avatar':
        logic.selectAvatar();
        break;
      case 'banner':
        logic.selectBanner();
        break;
      case 'commit':
        logic.commit();
        break;
      case 'twitter':
        Map<String, String>? result = await logic.twitterAuth();

        Get.dialog(DialogX(
          title: 'warning',
          contentWidget: _textField(controller: state.twitterController, hint: '', maxLines: 3),
          left: 'cancel',
          right: 'OK',
          needPop: false,
          leftCallback: () => Get.back(),
          rightCallback: () => logic.sendTwitter(token: result?['oauth_token'], verifier: result?['oauth_verifier']),
        ));
        break;
    }
  }
}
