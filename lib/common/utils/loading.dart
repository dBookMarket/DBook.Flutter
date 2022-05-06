import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'logger.dart';

class Loading {
  static init() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 35.0
      ..lineWidth = 2
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.black.withOpacity(0.7)
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = true
      ..dismissOnTap = false
      ..maskType = EasyLoadingMaskType.custom;
  }
}


showLoading({String? t = '加载中...'}) {
  EasyLoading.instance.userInteractions = false;
  EasyLoading.show(status: t ?? 'Loading...');
}

showSuccess({String? t}) {
  EasyLoading.showSuccess(t ?? '加载成功!', dismissOnTap: false);
  logX.d('加载成功>>>>$t');
}

showProgress(double progress,{String? status,}) {
  EasyLoading.instance..userInteractions = false;
  EasyLoading.showProgress(progress,status: status);
}

showError({String? t}) {
  EasyLoading.showError(t ?? '加载失败!', dismissOnTap: false);
  logX.d('加载失败>>>>$t');
}

showInfo({String? t}) {
  EasyLoading.showInfo(t ?? '', dismissOnTap: false);
}

dismissLoading() {
  EasyLoading.instance.userInteractions = true;
  EasyLoading.dismiss();
}

showToast(String value) {
  EasyLoading.showToast(value, dismissOnTap: false);
}