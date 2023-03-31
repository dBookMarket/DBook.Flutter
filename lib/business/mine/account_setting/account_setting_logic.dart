import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'account_setting_state.dart';

class AccountSettingLogic extends GetxController {
  final AccountSettingState state = AccountSettingState();

  getVersion()async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    state.versionName.value = packageInfo.version;
  }

  @override
  void onInit() {
    getVersion();
    super.onInit();
  }
}
