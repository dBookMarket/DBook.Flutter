import 'package:dbook/common/values/colors.dart';
import 'package:dbook/common/values/fontSize.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appBar.dart';
import 'publish_authorize_logic.dart';

class PublishAuthorizePage extends StatelessWidget {
  final logic = Get.put(PublishAuthorizeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _body(),
    );
  }

  _body()=>Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      _circleBg()
    ],
  );

  // 圆形的图片背景
  Widget _circleBg() {
    return Container(
      width: 136.r,
      height: 136.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: ColorX.txtTitle,
          width: 1.w,
        ),
      ),
      child: TextX('NFT',color: ColorX.txtBrown,fontSize: FontSizeX.s20,),
    );
  }
}
