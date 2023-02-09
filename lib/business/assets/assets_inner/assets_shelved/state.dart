import '../../../../common/widgets/refresh_list_view/state.dart';

class AssetsShelvedState extends RefreshListViewState{
  AssetsShelvedState() {
    this.initRefresh = false;
    this.disableShimmer = true;
    this.initData = true;
  }
}
