import '../../../../common/widgets/refresh_list_view/state.dart';

class AssetsDraftState  extends RefreshListViewState{
  AssetsDraftState() {
    this.initRefresh = true;
    this.disableShimmer = false;
    this.initData = true;
  }
}
