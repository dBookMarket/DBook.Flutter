import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../values/values.dart';
import 'button.dart';

// ignore: must_be_immutable
class DialogX extends StatelessWidget {
  String? title;
  String? content;
  Widget? contentWidget;
  String? left;
  String? right;
  Color? leftColor;
  Color? rightColor;
  bool titleCenter;
  bool? needPop;
  VoidCallback? leftCallback;
  VoidCallback? rightCallback;

  DialogX(
      {Key? key,
      this.title,
      this.content,
      this.contentWidget,
      this.left,
      this.right,
      this.leftColor,
      this.rightColor,
      this.titleCenter = true,
      this.needPop = true,
      this.leftCallback,
      this.rightCallback});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      // insetPadding: EdgeInsets.symmetric(horizontal: 120.w),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(28.r)), color: ColorX.bgDialog),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _title(),
            _content(),
            _action(context),
            SizedBox(height: 70.h),
          ],
        ),
      ),
    );
  }

  Widget _title() => Container(
        margin: EdgeInsets.only(top: 70.h),
        alignment: this.titleCenter ? Alignment.center : Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 68.w),
        child: Text(
          this.title ?? '提示',
          style: TextStyle(color: ColorX.txtTitle, fontSize: FontSizeX.s16, fontWeight: FontWeight.bold),
        ),
      );

  Widget _content() => Container(
        margin: EdgeInsets.only(top:(contentWidget == null && content == null) ? 0 : 50.h),
        constraints: BoxConstraints(maxHeight: 0.6.sh),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: contentWidget ??
                (content == null
                    ? SizedBox()
                    : Text(
                        this.content ?? '',
                        style: TextStyle(color: ColorX.txtDesc, fontSize: FontSizeX.s18),
                      )),
          ),
        ),
      );

  Widget _action(BuildContext context) => Container(
    margin: EdgeInsets.only(top: 80.h),
        padding: EdgeInsets.symmetric(horizontal: 88.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            left == null
                ? SizedBox()
                : Expanded(
                    child: ButtonX(
                    left!,
                    autoWidth: true,
                    borderRadius: 100.r,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    backgroundColor: this.leftColor ?? ColorX.buttonInValid,
                    borderColor: ColorX.buttonInValid,
                    textColor: ColorX.txtTitle,
                    borderWidth: 3.r,
                    fontSize: FontSizeX.s14,
                    onPressed: () {
                      if(needPop??true){
                        Navigator.pop(context);
                      }
                      if (leftCallback != null) {
                        leftCallback!();
                      }
                    },
                  )),
            SizedBox(width: (left == null || right == null) ? 0 : 84.w),
            right == null
                ? SizedBox()
                : Expanded(
                    child: ButtonX(
                    right!,
                    autoWidth: true,
                    borderRadius: 100.r,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    backgroundColor: this.rightColor ?? ColorX.buttonYellow,
                    borderColor: ColorX.buttonYellow,
                    textColor: ColorX.txtWhite,
                    fontSize: FontSizeX.s14,
                    onPressed: () {
                      if(needPop??true){
                        Navigator.pop(context);
                      }

                      if (rightCallback != null) {
                        rightCallback!();
                      }
                    },
                  )),
          ],
        ),
      );
}
