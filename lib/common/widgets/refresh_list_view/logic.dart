
import '../../utils/logger.dart';
import '../list_view/logic.dart';
import 'state.dart';

abstract class RefreshListViewLogic<T> extends ListViewLogic<T> {
  late final RefreshListViewState refreshState;

  @override
  void onReady() {
    if(refreshState.initData??false) refresh();
    super.onReady();
  }

  @override
  void onClose() {
    refreshState.refreshController.dispose();
    super.onClose();
  }

  Future<List<T>?> loadData({int pageNum});

  Future<List<T>?> loadMore() async {
    try {
      List<T>? data = await loadData(pageNum: ++refreshState.currentPageNum);
      if (data == null || data.isEmpty) {
        refreshState.currentPageNum--;
        refreshState.refreshController.loadNoData();
      } else {
        refreshState.list.addAll(data);
        onCompleted(data,isRefresh: false);
        if (data.length < refreshState.pageSize) {
          refreshState.refreshController.loadNoData();
        } else {
          refreshState.refreshController.loadComplete();
        }
      }
      return data;
    } catch (e) {
      refreshState.currentPageNum--;
      refreshState.refreshController.loadFailed();
    }
  }

  Future<List<T>?> refresh({bool init = false, bool enableLoading = true}) async {
    try {
      if (refreshState.initRefresh! && refreshState.firstInit) refreshState.setBusy(enableLoading: refreshState.disableShimmer!);
      refreshState.currentPageNum = refreshState.pageNumFirst;
      refreshState.refreshController.resetNoData();
      var data = await loadData(pageNum: refreshState.pageNumFirst).onError((error, stackTrace) => refreshState.setError(enableLoading: false));
      if (data == null || data.isEmpty || data.length == 0) {
        refreshState.list.clear();
        onCompleted([],isRefresh: true);
        refreshState.refreshController.refreshCompleted();
        refreshState.refreshController.loadComplete();
        if (refreshState.initRefresh!) refreshState.setEmpty(enableLoading: refreshState.disableShimmer!);
        refreshState.firstInit = false;
      } else {
        refreshState.list.clear();
        refreshState.list.addAll(data);
        // refreshState.list.refresh();
        onCompleted(refreshState.list,isRefresh: true);
        refreshState.refreshController.refreshCompleted();
        if (data.length < refreshState.pageSize) {
          refreshState.refreshController.loadNoData();
          refreshState.canLoadMore = false;
        } else {
          refreshState.refreshController.loadComplete();
          refreshState.canLoadMore = true;
        }
        if (refreshState.initRefresh! && refreshState.firstInit) refreshState.setIdle(enableLoading: refreshState.disableShimmer!);
        refreshState.firstInit = false;

        refreshState.setIdle(enableLoading: false);
      }
      onRefreshCompleted();
    } catch (e) {
      refreshState.setError(enableLoading: false);
      logX.e(e,'列表加载错误');
    }
  }

  onRefreshCompleted() {}
}
