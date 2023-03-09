import 'package:get/get.dart';

import '../../../../common/widgets/refresh_list_view/state.dart';

class WalletActivityState extends RefreshListViewState{
  bool needAppBar = false;

  WalletActivityState() {
    this.initRefresh = true;
    this.disableShimmer = false;
    this.initData = true;

    needAppBar = Get.arguments?['needAppBar']??false;
  }
}