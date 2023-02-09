import '../../../../common/widgets/refresh_list_view/state.dart';

class AssetsPendingState extends RefreshListViewState{
  AssetsPendingState() {
    this.initRefresh = false;
    this.disableShimmer = true;
    this.initData = true;
  }
}
