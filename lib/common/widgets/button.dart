import 'package:dbook/common/utils/keyboard.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 扁平圆角按钮
Widget btnFlatButtonWidget({
  required VoidCallback onPressed,
  double width = 140,
  double height = 44,
  Color gbColor = ColorX.primaryBackground,
  String title = "button",
  Color fontColor = ColorX.txtTitle,
  double fontSize = 18,
  String fontName = "Montserrat",
  FontWeight fontWeight = FontWeight.w400,
}) {
  return Container(
    width: width.w,
    height: height.h,
    child: TextButton(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(TextStyle(
          fontSize: 16.sp,
        )),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.focused) &&
                !states.contains(MaterialState.pressed)) {
              return Colors.blue;
            } else if (states.contains(MaterialState.pressed)) {
              return Colors.deepPurple;
            }
            return fontColor;
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.blue[200];
          }
          return gbColor;
        }),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: Radii.k6pxRadius,
        )),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor,
          fontFamily: fontName,
          fontWeight: fontWeight,
          fontSize: fontSize.sp,
          height: 1,
        ),
      ),
      onPressed: onPressed,
    ),
  );
}

/// 第三方按钮
Widget btnFlatButtonBorderOnlyWidget({
  required VoidCallback onPressed,
  double width = 88,
  double height = 44,
  required String iconFileName,
}) {
  return Container(
    width: width.w,
    height: height.h,
    child: TextButton(
      style: ButtonStyle(
        // textStyle: MaterialStateProperty.all(TextStyle(
        //   fontSize: 16.sp,
        // )),
        // foregroundColor: MaterialStateProperty.resolveWith(
        //   (states) {
        //     if (states.contains(MaterialState.focused) &&
        //         !states.contains(MaterialState.pressed)) {
        //       return Colors.blue;
        //     } else if (states.contains(MaterialState.pressed)) {
        //       return Colors.deepPurple;
        //     }
        //     return AppColors.primaryElementText;
        //   },
        // ),
        // backgroundColor: MaterialStateProperty.resolveWith((states) {
        //   if (states.contains(MaterialState.pressed)) {
        //     return Colors.blue[200];
        //   }
        //   return AppColors.primaryElement;
        // }),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: Radii.k6pxRadius,
        )),
      ),
      child: Image.asset(
        "assets/images/icons-$iconFileName.png",
      ),
      onPressed: onPressed,
    ),
  );
}

// ignore: must_be_immutable
class ButtonX extends StatelessWidget {
  String txt;
  Color textColor;
  double? fontSize;
  VoidCallback? onPressed;
  bool? enable = true;
  Color? backgroundColor;
  EdgeInsets? padding;
  EdgeInsets? margin;
  double? borderRadius;
  double? width;
  Color? primary;
  FontWeight? fontWeight;
  bool? autoWidth;
  Color? borderColor;
  double? borderWidth;
  LinearGradient? linearGradient;

  ButtonX(
      this.txt, {
        Key? key,
        this.onPressed,
        this.enable,
        this.backgroundColor = ColorX.buttonValid,
        this.textColor = ColorX.buttonText,
        this.fontSize,
        this.padding,
        this.width,
        this.margin,
        this.borderRadius,
        this.primary,
        this.fontWeight,
        this.autoWidth,
        this.borderColor,
        this.borderWidth,
        this.linearGradient,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin ?? EdgeInsets.all(0),
      constraints: BoxConstraints(minWidth: autoWidth ?? false ? 0.1 : 1.sw-42.w*2),
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: 20.h,
            vertical: 26.h,
          ),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 20.r),
          border: Border.all(color: borderColor ?? Colors.transparent, width: borderWidth ?? 1.r),
          gradient: linearGradient
      ),
      child: GestureDetector(
        child: TextX(txt, color: this.textColor, fontSize: this.fontSize ?? 36.sp, height: 1.1, fontWeight: fontWeight),
        onTap: () {
          if (this.enable ?? true && this.onPressed != null) {
            KeyboardX.keyboardBack();
            this.onPressed!();
          }
        },
      ),
    );
  }
}