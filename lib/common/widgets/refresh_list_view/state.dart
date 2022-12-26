
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../list_view/state.dart';

class RefreshListViewState<T> extends ListViewState<T>{

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  RefreshController get refreshController => _refreshController;
  int currentPageNum = 1;
  var canLoadMore = false;

  // 是否直接加载数据
  bool? initData;
  // 是否在第一次加载loading或shimmer
  bool? initRefresh;
  bool? disableShimmer;

  bool firstInit = true;

  RefreshListViewState() {
    ///Initialize variables
  }
}
