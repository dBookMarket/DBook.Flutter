import 'package:dbook/common/routes/routes.dart';
import 'package:dbook/common/store/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/logger.dart';

/// 检查是否登录
class RouteTwitterAuthMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 1;

  RouteTwitterAuthMiddleware({this.priority});

  @override
  RouteSettings? redirect(String? route) {
    logX.d('是否twitter认证>>>>>>${UserStore.to.userInfo.isVerified}');
    if (UserStore.to.userInfo.isVerified??false){
      return null;
    } else {
      return RouteSettings(name: AppRoutes.TwitterAuth);
    }
  }
}
