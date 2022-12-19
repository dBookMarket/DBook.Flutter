import 'package:dbook/common/utils/image_helper.dart';
import 'package:dbook/common/values/images.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:dbook/common/widgets/button.dart';
import 'package:dbook/common/widgets/line_widget.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/values/colors.dart';
import 'verify_password_logic.dart';


enum VerifyType{
  reLogin,
  verifyPassword
}

class VerifyPasswordPage extends StatelessWidget {
  final logic = Get.put(VerifyPasswordLogic());
  final state = Get.find<VerifyPasswordLogic>().state;

  final String? title;
  final VerifyType verifyType;

  VerifyPasswordPage({required this.verifyType,this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BaseContainer(
      viewState: state.viewState,
      child: Center(
        child: Container(
          width: 0.8.sw,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: ColorX.shadow, //底色,阴影颜色
              offset: Offset(0, 0), //阴影位置,从什么位置开始
              blurRadius: 1, // 阴影模糊层度
              spreadRadius: 0,
            )
          ], color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _title(),
              _input(),
              LineH(),
              Row(
                children: [
                  Expanded(
                      child: ButtonX(
                        'Cancel',
                        backgroundColor: Colors.transparent,
                        textColor: ColorX.txtHint,
                        autoWidth: true,
                        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 40.w),
                        fontSize: 30.sp,
                        onPressed: () => _onClick('close'),
                      )),
                  LineV(
                    height: 60.h,
                  ),
                  Expanded(
                      child: ButtonX(
                        'OK',
                        backgroundColor: Colors.transparent,
                        textColor: ColorX.txtTitle,
                        autoWidth: true,
                        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 40.w),
                        fontSize: 30.sp,
                        onPressed: () => _onClick('confirm'),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
      background: Colors.transparent,
    ),backgroundColor: Colors.transparent,);
  }

  Widget _title() => Container(
        color: ColorX.primaryHeader,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: SizedBox()),
            TextX(this.title ?? 'Password verification'),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => _onClick('close'),
                  child: Container(
                    child: ImageX(ImageConstants.close, color: ColorX.txtDesc, width: 30.w, height: 30.w),
                    padding: EdgeInsets.all(30.r),
                  ),
                )
              ],
            )),
          ],
        ),
      );

  Widget _input() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 60.h),
      child: TextField(
        maxLines: 1,
        maxLength: 64,
        // focusNode: state.commentFocus,
        textAlignVertical: TextAlignVertical.bottom,
        textAlign: TextAlign.center,
        onChanged: logic.onTextChanged,
        // controller: state.commentInputController,
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 22.h),
          // fillColor: ColorX.bgInput,
          // filled: true,
          hintText: '',
          hintStyle: TextStyle(color: ColorX.txtHint, fontSize: 36.sp),
          counterText: '',
          enabledBorder: OutlineInputBorder(
            /*边角*/
            borderRadius: BorderRadius.all(
              Radius.circular(12.r),
            ),
            borderSide: BorderSide(
              color: ColorX.border,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorX.border, width: 1)),
          border: OutlineInputBorder(borderSide: BorderSide(color: ColorX.border, width: 1)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorX.border, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
          ),
        ),
      ),
    );
  }

  _onClick(event) {
    switch (event) {
      case 'close':
        Get.back();
        break;
      case 'confirm':
        logic.onConfirm(this.verifyType);
        break;
    }
  }
}
