import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/entities/assets_info_entity.dart';

class AssetsState {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  int currentPageNum = 1;
  final int pageNumFirst = 1;
  var canLoadMore = false;

  final list = <AssetsInfoResults>[].obs;
  AssetsState() {
    ///Initialize variables
  }
}
