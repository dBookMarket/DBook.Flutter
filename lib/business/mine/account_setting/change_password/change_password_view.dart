import 'package:dbook/common/store/user.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/dialog.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/utils/image_helper.dart';
import '../../../../common/values/fontSize.dart';
import '../../../../common/values/images.dart';
import '../../../../common/widgets/appBar.dart';
import '../../../../common/widgets/button.dart';
import '../../../../common/widgets/view_state/base_container_view.dart';
import 'change_password_logic.dart';

class ChangePasswordPage extends StatelessWidget {
  final logic = Get.put(ChangePasswordLogic());
  final state = Get.find<ChangePasswordLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Change the password'),
      body: _body(),
    );
  }

  Widget _body() => BaseContainer(
      viewState: state.viewState,
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 36.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextX('Old password', color: ColorX.txtDesc),
          SizedBox(height: 28.h),
          _input(controller: state.oldPasswordController, hint: 'Please enter a password'),
          SizedBox(height: 28.h),
          TextX('New password', color: ColorX.txtDesc),
          SizedBox(height: 28.h),
          _input(controller: state.passwordController, hint: 'Please enter a password'),
          SizedBox(height: 28.h),
          _input(controller: state.passwordAgainController, hint: 'Please enter the password again'),
          SizedBox(height: 40.h),
          InkWell(
              child: TextX(
                'Forgot your password? Reset your password',
                color: ColorX.txtBrown,
                fontSize: FontSizeX.s13,
              ),
              onTap: _reLogin),
          Expanded(child: SizedBox()),
          ButtonX('Revise', borderRadius: 0, onPressed: () => logic.revisePassword())
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
        style: TextStyle(color: Colors.black, fontSize: FontSizeX.s13, textBaseline: TextBaseline.alphabetic),
        controller: controller,
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.fromLTRB(32.w, 20.h, 32.w, 20.h),
          fillColor: Colors.white,
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xFF999999), fontSize: FontSizeX.s13, textBaseline: TextBaseline.alphabetic),
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
          child: ImageX(state.hint.value ? ImageConstants.closeEye : ImageConstants.openEye, width: 20, height: 20, color: Colors.black),
          onTap: () => logic.toggleEye(),
        );
      });

  _reLogin() {
    Get.dialog(DialogX(content: 'Do you want to log out of this account and log in again?',left: 'Cancel', right: 'OK', rightCallback: () => {
      Get.close(2),
      UserStore.to.onLogout(),
    }));
  }
}
