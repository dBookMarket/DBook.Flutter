import '../../../../common/widgets/refresh_list_view/state.dart';

class AssetsPendingState extends RefreshListViewState{
  AssetsPendingState() {
    this.initRefresh = true;
    this.disableShimmer = false;
    this.initData = true;
  }
}
