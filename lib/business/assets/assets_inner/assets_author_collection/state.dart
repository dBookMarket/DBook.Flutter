import 'package:get/get.dart';

import '../../../../common/widgets/refresh_list_view/state.dart';

class AssetsAuthorCollectionState extends RefreshListViewState{
  late String? authorId;
  AssetsAuthorCollectionState() {
    this.initRefresh = true;
    this.disableShimmer = false;
    this.initData = true;

    authorId = Get.arguments?['userId'] ?? '';
  }
}
