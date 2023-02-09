import '../../../../common/widgets/refresh_list_view/state.dart';

class AssetsEarningsState extends RefreshListViewState {

  AssetsEarningsState() {
    this.initRefresh = true;
    this.disableShimmer = false;
    this.initData = true;
  }
}
