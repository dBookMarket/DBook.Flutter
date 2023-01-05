import 'package:dbook/common/config/app_config.dart';
import 'package:dbook/common/store/store.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'assets_logic.dart';

class AssetsPage extends StatelessWidget {
  final logic = Get.put(AssetsLogic());
  final state = Get.find<AssetsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _headerBg(),
        appBar(title: 'My books', backgroundColor: Colors.transparent, actions: [_action()], backColor: Colors.white, txtColor: Colors.white)
      ],
    );
  }

  Widget _action() => GestureDetector(
        child: Container(
          padding: EdgeInsets.only(right: ScreenConfig.marginH),
          child: SvgPicture.asset(
            Assets.svgShare,
            width: 50.r,
          ),
        ),
      );

  Widget body() => Container();

  Widget _headerBg() => Obx(() {
        if (UserStore.to.userInfo.bannerUrl == null || UserStore.to.userInfo.bannerUrl!.isEmpty) return SizedBox();
        return Image.network(
          UserStore.to.userInfo.bannerUrl ?? '',
          width: 1.sw,
          height: 0.6.sw,
          fit: BoxFit.cover,
        );
      });
}
