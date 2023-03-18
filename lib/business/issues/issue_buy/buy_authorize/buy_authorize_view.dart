import 'package:dbook/common/utils/string_helper.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/button.dart';
import '../../../../common/widgets/text.dart';
import 'buy_authorize_logic.dart';

class BuyAuthorizePage extends StatelessWidget {
  final logic = Get.put(BuyAuthorizeLogic());
  final state = Get.find<BuyAuthorizeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar(), body: _body());
  }

  Widget _body() => Obx(() {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 30.h),
          child: Column(
          children: [
            _title(state.chainTitle),
            _fromTo(),
            _bookInfo(),
            _feeInfo(),
            Spacer(),
            _action(),
          ],
        ),);
      });

  // 原点标题
  Widget _title(String title) => Container(
        margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
        child: Row(
          children: [
            Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(color: ColorX.txtTitle, borderRadius: BorderRadius.circular(2)),
            ),
            SizedBox(width: 10.w),
            TextX(title, color: ColorX.txtTitle, fontSize: FontSizeX.s13),
          ],
        ),
      );

  // 从A账户向B账户转账
  Widget _fromTo() => Container(
        margin: EdgeInsets.symmetric( vertical: 15.h),
        child: Row(
          children: [
            _addressText(state.from),
            _arrow(),
            _addressText(state.to),
          ],
        ),
      );

  // 带背景的文字
  Widget _addressText(String? text) => Expanded(
          child: Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        alignment: Alignment.center,
        color: ColorX.primaryYellow2,
        child: TextX(formatAddress(text,startLength: 8,endLength: 6), color: ColorX.txtTitle, fontSize: FontSizeX.s13),
      ));

  // 带黑色背景的原型右箭头
  Widget _arrow() => Container(
        width: 40.w,
        height: 40.w,
        margin: EdgeInsets.symmetric(horizontal: 17.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20.sp),
      );

  // 具有边框的容器，左边是图片(图片宽126.px,高156.px)，右边是垂直布局的文字
  Widget _bookInfo() => _borderContainer(
      Row(
        children: [
          Image.network(state.cover, width: 126.w, height: 156.h, fit: BoxFit.cover),
          SizedBox(width: 20.w),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextX(
                state.bookName,
                color: ColorX.txtTitle,
                fontSize: FontSizeX.s13,
                maxLines: 2,
                textAlign: TextAlign.start,
              ),
              Spacer(),
              Row(
                children: [
                  SvgPicture.asset(state.coinCover, width: 20.w, height: 20.w),
                  SizedBox(width: 10.w),
                  TextX(state.price.toString(), color: ColorX.txtTitle, fontSize: FontSizeX.s13),
                  Spacer(),
                  TextX('x${state.quantity}', color: ColorX.txtTitle, fontSize: FontSizeX.s13),
                ],
              )
            ],
          )),
        ],
      ),
      h: 186.h);

  Widget _feeInfo() => _borderContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Detail'),
          SizedBox(height: 30.h),
          _gasFee(),
          SizedBox(height: 30.h),
          _total(),
        ],
      ));

  Widget _gasFee()=>Container(
    width: 1.sw,
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    alignment: Alignment.center,
    color: ColorX.primaryYellow2,
    child: Row(children: [
      TextX('Expect to pay the gas fee:', color: ColorX.txtTitle, fontSize: FontSizeX.s13),
      Spacer(),
      TextX('≈${state.transactionFee.value}', color: ColorX.txtTitle, fontSize: FontSizeX.s13),
    ],),
  );

  // 总金额
  Widget _total() => Container(
        margin: EdgeInsets.symmetric(vertical: 15.h),
        child: Row(
          children: [
            TextX('Total payment', color: ColorX.txtTitle, fontSize: FontSizeX.s13),
            Spacer(),
            TextX(state.total.toString(), color: ColorX.txtTitle, fontSize: FontSizeX.s13),
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

  // 带边框的容器
  Widget _borderContainer(Widget child, {double? h}) => Container(
        margin: EdgeInsets.symmetric(vertical: 15.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        height: h,
        decoration: BoxDecoration(
          border: Border.all(color: ColorX.txtTitle, width: 1.r),
        ),
        child: child,
      );
}
