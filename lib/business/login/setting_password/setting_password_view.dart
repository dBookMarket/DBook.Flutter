import 'package:dbook/common/utils/image_helper.dart';
import 'package:dbook/common/values/images.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/button.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'setting_password_logic.dart';

class SettingPasswordPage extends StatelessWidget {
  final logic = Get.put(SettingPasswordLogic());
  final state = Get.find<SettingPasswordLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Login'),
      body: _body(),
    );
  }

  Widget _body() => BaseContainer(
      viewState: state.viewState,
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 36.h),
      child: Column(
        children: [
          _input(controller: state.passwordController, hint: 'Please enter a password'),
          SizedBox(height: 28.h),
          _input(controller: state.passwordAgainController, hint: 'Please enter the password again'),
          Expanded(child: SizedBox()),
          ButtonX('Next',borderRadius: 0, onPressed: () => logic.importMemories())
        ],
      ));

  Widget _input({
    required controller,
    required String hint,
  }) {
    return Obx(() {
      return TextField(
        maxLines: 1,
        maxLength: 300,
        // textAlignVertical: TextAlignVertical.bottom,
        textAlign: TextAlign.start,
        obscureText: state.hint.value,
        style: TextStyle(color: Colors.black, fontSize: FontSizeX.s13,textBaseline: TextBaseline.alphabetic),
        controller: controller,
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.fromLTRB(32.w, 20.h, 32.w, 20.h),
          fillColor: Colors.white,
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xFF999999), fontSize: FontSizeX.s13,textBaseline: TextBaseline.alphabetic),
          counterText: '',
          suffix: _eye(),
          enabledBorder: OutlineInputBorder(
            /*边角*/
            borderRadius: BorderRadius.all(
              Radius.circular(15.r),
            ),
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.r,
            ),
          ),
          disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.r, color: Colors.black)),
          border: OutlineInputBorder(borderSide: BorderSide(width: 1.r, color: Colors.black)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.r,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15.r),
            ),
          ),
        ),
      );
    });
  }

  Widget _eye() => Obx(() {
        return GestureDetector(
          child: ImageX(state.hint.value ? ImageConstants.closeEye : ImageConstants.openEye, width: 20, height: 20,color: Colors.black),
          onTap: () => logic.toggleEye(),
        );
      });
}
