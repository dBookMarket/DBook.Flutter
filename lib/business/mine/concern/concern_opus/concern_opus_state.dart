import '../../../../common/widgets/refresh_list_view/state.dart';

class ConcernOpusState extends RefreshListViewState{
  ConcernOpusState() {
    this.initRefresh = true;
    this.disableShimmer = false;
    this.initData = true;
  }
}
