import 'package:dbook/common/values/colors.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

import '../config/app_config.dart';
import '../utils/image_helper.dart';

/// 透明背景 AppBar
AppBar transparentAppBar({
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: title != null
        ? Center(
            child: title,
          )
        : null,
    leading: leading,
    actions: actions,
  );
}

AppBar appBar(
    {required String title,
    bool? centerTitle,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
    Color? backgroundColor,
    Color? txtColor,
    Color? backColor,
    bool? canPop = true,
    goBack}) {
  // statusBarColor = backgroundColor??ColorX.appbar_bg_color;
  return AppBar(
    centerTitle: centerTitle ?? true,
    // elevation: 0.2,
    toolbarHeight: ScreenConfig.appBarHeight,
    // backgroundColor: backgroundColor ?? Colors.red,
    backgroundColor: backgroundColor ?? ColorX.primaryYellow,
    leading: canPop!
        ? appBarLeading(
            color: backColor,
            onTap: goBack ?? Get.back,
          )
        : SizedBox(),
    title: appBarTitle(
      title: title,
      titleColor: txtColor,
    ),
    actions: actions ?? [],
    bottom: bottom,
  );
}

Widget appBarLeading({required VoidCallback onTap, Color? color}) {
  return IconButton(
    onPressed: onTap,
    padding: EdgeInsets.only(left: 0, top: 4),
    icon: SvgPicture.asset(Assets.svgBack,height: 20,color: color??ColorX.appBarTitle),
  );
}

Widget appBarTitle({Key? key, required String title, Color? titleColor}) {
  return Text(
    title,
    style: TextStyle(color: titleColor ?? ColorX.appBarTitle, fontSize: 42.sp, fontWeight: FontWeight.w500),
  );
}
