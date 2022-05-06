import 'package:dbook/common/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'import_private_key_logic.dart';

class ImportPrivateKeyPage extends StatelessWidget {
  final logic = Get.put(ImportPrivateKeyLogic());
  final state = Get.find<ImportPrivateKeyLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
    return Scaffold(appBar: appBar(title: 'title'),body: Column(
      children: [
        _input(),
        Expanded(child: SizedBox()),

      ],
    ),);
  }


  Widget _input() {
    return TextField(
      maxLines: 1,
      maxLength: 300,
      focusNode: state.memoriesFocus,
      textAlignVertical: TextAlignVertical.bottom,
      textAlign: TextAlign.start,
      onChanged: logic.onMemoriesInput,
      controller: state.memoriesInputController,
      decoration: InputDecoration(
        isCollapsed: true,
        contentPadding: EdgeInsets.fromLTRB(68.w, 22.h, 68.w, 22.h),
        fillColor: Color(0xFFF6F6F6),
        filled: true,
        hintText: '发一条评论吧',
        hintStyle: TextStyle(color: Color(0xFF999999), fontSize: 36.sp),
        counterText:'',
        enabledBorder: OutlineInputBorder(
          /*边角*/
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(50), //边角为30
          ),
        ),
      ),
    );
  }
}
