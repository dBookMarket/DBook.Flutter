import 'package:dbook/common/store/user.dart';
import 'package:dbook/common/values/colors.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/avatar_widget.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'mine_logic.dart';

class MinePage extends StatelessWidget {
  final logic = Get.put(MineLogic());
  final state = Get.find<MineLogic>().state;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(viewState: state.viewState, child: _body());
  }

  Widget _body() => Stack(children: [_headerBg(), _content()]);

  Widget _headerBg() => Container(
        width: 1.sw,
        height: 432.h,
        color: ColorX.primaryYellow,
      );

  Widget _content() => Column(children: [_title()]);

  Widget _title() => Stack(
        children: [
          Container(width: 1.sw, child: TextX('Personal Center', fontSize: FontSizeX.s16, color: ColorX.txtBrown), margin: EdgeInsets.only(top: 60.h)),
          Container(
            width: 1.sw,
            child: SvgPicture.asset(Assets.svgCreateBook, width: 40.r, height: 40.r),
            margin: EdgeInsets.only(top: 60.h, right: 40.w),
            alignment: Alignment.topRight,
          ),
        ],
      );


  Widget _userInfo() {
    return Row(children: [AvatarX(UserStore.to.token)]);
  }
}
