import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dbook/common/services/services.dart';
import 'package:dbook/common/store/store.dart';
import 'package:dbook/common/utils/utils.dart';
import 'package:get/get.dart';

import 'common/key_manager/keystore_manager.dart';
import 'common/services/global_time.dart';
import 'common/store/web3.dart';

/// 全局静态数据
class Global {
  /// 初始化
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await DirectoryUtil.initAppDocDir();

    setSystemUi();
    Loading();

    await Web3KeychainManager.init();

    await Get.putAsync<StorageService>(() => StorageService().init());
    await Get.putAsync(() async => GlobalTimeService().init());

    Get.put<ConfigStore>(ConfigStore());
    Get.put<UserStore>(UserStore());
    Get.put<Web3Store>(Web3Store());

    DirectoryUtil.initAppDocDir();
  }

  static void setSystemUi() {
    if (GetPlatform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
