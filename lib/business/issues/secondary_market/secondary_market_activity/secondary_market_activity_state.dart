import 'package:get/get.dart';

import '../../../../common/entities/issues_entity.dart';
import '../../../../common/widgets/refresh_list_view/state.dart';

class SecondaryMarketActivityState extends RefreshListViewState {
  late IssuesEntity issuesInfo;

  SecondaryMarketActivityState() {
    this.initRefresh = true;
    this.disableShimmer = false;
    this.initData = true;
    issuesInfo = Get.arguments?['detail'] ?? IssuesEntity();
  }
}
