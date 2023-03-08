import 'package:dbook/common/values/colors.dart';
import 'package:dbook/common/values/fontSize.dart';
import 'package:dbook/common/widgets/button.dart';
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

  _body() => Container(
        margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _circleBg(),
            SizedBox(height: 38.h),
            TextX(logic.content, color: ColorX.txtTitle, fontSize: FontSizeX.s18, maxLines: 10),
            SizedBox(height: 52.h),
            TextX(logic.desc, color: ColorX.txtDesc, fontSize: FontSizeX.s13, maxLines: 10),
            _gas(),
            Spacer(),
            _action()
          ],
        ),
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
      child: TextX('NFT', color: Color(0xFFAD8141), fontSize: FontSizeX.s20, fontWeight: FontWeight.bold),
    );
  }

  Widget _gas() => Container(
        width: 1.sw,
        color: ColorX.primaryYellow2,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 36.h),
        margin: EdgeInsets.symmetric(vertical: 60.h),
        child: Column(
          children: [
            TextX('${logic.feeDesc}\n\n${logic.gasPrice.value}', color: ColorX.txtDesc, fontSize: FontSizeX.s13, maxLines: 4, textAlign: TextAlign.start),
          ],
        ),
      );

  Widget _action() => Row(children: [
        Expanded(child: ButtonX('Cancel', borderRadius: 0, fontSize: FontSizeX.s13, textColor: ColorX.txtDesc, backgroundColor: ColorX.buttonYellow, autoWidth: true, onPressed: () => _onClick('Cancel'))),
        SizedBox(width: 22.w),
        Expanded(child: ButtonX('OK', borderRadius: 0, fontSize: FontSizeX.s13, textColor: ColorX.txtYellow, backgroundColor: ColorX.buttonBrown, autoWidth: true, onPressed: () => _onClick('OK'))),
      ]);

  _onClick(action) {
    switch (action) {
      case 'OK':
        Get.back(result: true);
        break;
      case 'Cancel':
        Get.back(result: null);
        break;
    }
  }
}
