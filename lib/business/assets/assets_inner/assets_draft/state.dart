import '../../../../common/widgets/refresh_list_view/state.dart';

class AssetsDraftState  extends RefreshListViewState{
  AssetsDraftState() {
    this.initRefresh = false;
    this.disableShimmer = true;
    this.initData = true;
  }
}
