import 'package:get/get.dart';

import '../../../../common/widgets/refresh_list_view/state.dart';
import '../../assets_state.dart';

class AssetsEarningsState extends RefreshListViewState {
  late AssetsType assetsType;
  late String? userId;
  AssetsEarningsState() {
    this.initRefresh = true;
    this.disableShimmer = false;
    this.initData = true;
    assetsType = Get.arguments?['assetsType'] ?? AssetsType.MY_BOOKS;
    userId = Get.arguments?['userId']??'';
  }
}
