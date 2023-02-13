import '../../../../common/widgets/refresh_list_view/state.dart';

class AssetsPendingOrdersState extends RefreshListViewState{
  AssetsPendingOrdersState() {
    this.initRefresh = true;
    this.disableShimmer = false;
    this.initData = true;
  }
}