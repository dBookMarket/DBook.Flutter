import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../values/colors.dart';

class TextX extends StatelessWidget {
  static final FontWeight bold = Platform.isAndroid?FontWeight.bold:FontWeight.w500;
  static final double h = Platform.isAndroid ? 1.25 : 1.3;
  final Color? color;
  final double? fontSize;
  final double? height;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final String? value;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  TextX(this.value, {this.color, this.fontWeight, this.fontSize, this.style, this.maxLines, this.height, this.overflow, this.textAlign, this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return Text(
      value ?? '',
      style: style ??
          TextStyle(
              color: color ?? ColorX.txtTitle,
              fontSize: fontSize,
              fontWeight: fontWeight,
              height: height ?? h,
              overflow: overflow ?? TextOverflow.ellipsis,
              fontFamily: this.fontFamily),
      maxLines: maxLines,
      softWrap: true,
      textAlign: textAlign ?? TextAlign.center,
      strutStyle: StrutStyle(
        fontSize: fontSize,
        leading: 0,
        height: height ?? h,
        // 1.1更居中
        forceStrutHeight: true, // 关键属性 强制改为文字高度
      ),
    );
  }
}
