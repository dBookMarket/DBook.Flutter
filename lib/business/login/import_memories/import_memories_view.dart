import 'package:dbook/business/login/setting_password/setting_password_view.dart';
import 'package:dbook/common/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/widgets/appBar.dart';
import '../../../common/widgets/base_container_view.dart';
import '../../../common/widgets/button.dart';
import 'import_memories_logic.dart';

class ImportMemoriesPage extends StatelessWidget {
  final logic = Get.put(ImportMemoriesLogic());
  final state = Get
      .find<ImportMemoriesLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(title: ''),
      body: _body(),
    );
  }

  Widget _body() =>
      BaseContainer(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          children: [
            _input(),
            Expanded(child: SizedBox()),
            Obx(() {
              return ButtonX(
                'Next',
                enable: state.memories.value.isNotEmpty,
                backgroundColor: state.memories.isNotEmpty ? ColorX.buttonValid : ColorX.buttonInValid,
                onPressed: () => Get.to(()=>SettingPasswordPage(), arguments: Map.of({'memories': state.memories.value})),
              );
            }),
            SizedBox(height: 36.h)
          ],
        ),
      );

  Widget _input() {
    return TextField(
      maxLines: 10,
      maxLength: 300,
      controller: state.controller,
      textAlignVertical: TextAlignVertical.bottom,
      textAlign: TextAlign.start,
      onChanged: logic.onMemoriesInput,
      decoration: InputDecoration(
        isCollapsed: true,
        contentPadding: EdgeInsets.fromLTRB(32.w, 30.h, 32.w, 30.h),
        fillColor: Color(0xFFF6F6F6),
        filled: true,
        hintText: 'Please enter 12 mnemonics, in the order in which they were backed up, separated by spaces for each single time.',
        hintStyle: TextStyle(color: Color(0xFF999999), fontSize: 36.sp),
        counterText: '',
        enabledBorder: OutlineInputBorder(
          /*边角*/
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0, color: Colors.transparent)),
        border: OutlineInputBorder(borderSide: BorderSide(width: 0, color: Colors.transparent)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
        ),
      ),
    );
  }
}
