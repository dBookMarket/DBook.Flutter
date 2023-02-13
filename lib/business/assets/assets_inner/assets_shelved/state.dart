import '../../../../common/widgets/refresh_list_view/state.dart';

class AssetsShelvedState extends RefreshListViewState{
  AssetsShelvedState() {
    this.initRefresh = true;
    this.disableShimmer = false;
    this.initData = true;
  }
}
