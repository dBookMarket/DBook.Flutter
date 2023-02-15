import '../../../../common/widgets/refresh_list_view/state.dart';

class ConcernAuthorState extends RefreshListViewState{
  ConcernAuthorState() {
    this.initRefresh = true;
    this.disableShimmer = false;
    this.initData = true;
  }
}
