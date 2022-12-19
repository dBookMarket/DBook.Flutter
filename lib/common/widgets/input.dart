import 'package:dbook/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 无边框输入框
class InputWidget extends StatelessWidget {
  final String? hint;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool enable;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  const InputWidget({
    Key? key,
    this.hint,
    this.style,
    this.hintStyle,
    this.keyboardType,
    this.maxLength,
    this.maxLines,
    this.textAlign,
    this.focusNode,
    this.autofocus = false,
    this.enable = true,
    this.controller,
    this.inputFormatters,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller ?? TextEditingController(),
      textAlign: textAlign ?? TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      style: this.style ?? TextStyle(color: Colors.black, fontSize: 32.sp,height: TextX.h),
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      focusNode: focusNode,
      autofocus: autofocus,
      minLines: 1,
      enabled: enable,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      onChanged: this.onChanged,
      decoration: hint != null
          ? InputDecoration(
          contentPadding: EdgeInsets.all(1),
          isCollapsed: true,
          border: InputBorder.none,

          hintText: hint,
          hintStyle: hintStyle ?? TextStyle(color: Colors.grey, fontSize: 28.sp),
          counterText: '' //长度计数器
      )
          : null,
    );
  }
}
