import 'package:flutter/material.dart';
import 'package:dbook/common/routes/routes.dart';
import 'package:dbook/common/store/store.dart';

import 'package:get/get.dart';

import '../utils/logger.dart';

/// 检查是否登录
class RouteAuthMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 2;

  RouteAuthMiddleware({this.priority});

  @override
  RouteSettings? redirect(String? route) {
    logX.d('是否登录>>>>>>${UserStore.to.isLogin}');
    if (UserStore.to.isLogin || route == AppRoutes.ImportMemories || route == AppRoutes.SettingPassword) {
      return null;
    } else {
      return RouteSettings(name: AppRoutes.ImportMemories);
    }
  }
}
