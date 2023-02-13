import '../../../../common/widgets/refresh_list_view/state.dart';

class AssetsMyCollectionState extends RefreshListViewState{
  AssetsMyCollectionState() {
    this.initRefresh = true;
    this.disableShimmer = false;
    this.initData = true;
  }
}
