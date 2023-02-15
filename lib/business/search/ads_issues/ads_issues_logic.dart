import 'package:get/get.dart';

import '../../service_api/base/net_work.dart';
import 'ads_issues_state.dart';

class AdsIssuesLogic extends GetxController {
  final AdsIssuesState state = AdsIssuesState();

  _getBanner()async{
    state.list.value = await NetWork().assets.ads();
  }

  @override
  void onInit() {
    _getBanner();
    super.onInit();
  }
}
