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
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.r)), color: ColorX.bgDialog),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _title(),
            _content(),
            _action(context),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _title() => Container(
        margin: EdgeInsets.only(top: 30.h),
        alignment: this.titleCenter ? Alignment.center : Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 68.w),
        child: Text(
          this.title ?? 'attention',
          style: TextStyle(color: ColorX.txtTitle, fontSize: FontSizeX.s20),
        ),
      );

  Widget _content() => Container(
        margin: EdgeInsets.only(top:(contentWidget == null && content == null) ? 0 : 20.h),
        constraints: BoxConstraints(maxHeight: 0.6.sh),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: contentWidget ??
                (content == null
                    ? SizedBox()
                    : Text(
                        this.content ?? '',
                        style: TextStyle(color: ColorX.txtDesc, fontSize: FontSizeX.s16),
                      )),
          ),
        ),
      );

  Widget _action(BuildContext context) => Container(
    margin: EdgeInsets.only(top: 30.h),
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            left == null
                ? SizedBox()
                : Expanded(
                    child: ButtonX(
                    left!,
                    autoWidth: true,
                    borderRadius: 0.r,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    backgroundColor: this.leftColor ?? Color(0xFFFFF7E9),
                    borderColor: Color(0xFFFFF7E9),
                    textColor: Color(0xFF50483B),
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
                    borderRadius: 0.r,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    backgroundColor: this.rightColor ?? Color(0xFF50483B),
                    borderColor: Color(0xFF50483B),
                    textColor: Color(0xFFFFE1B4),
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
