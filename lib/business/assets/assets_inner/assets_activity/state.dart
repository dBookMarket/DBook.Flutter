import 'package:dbook/common/widgets/refresh_list_view/state.dart';

class AssetsActivityState extends RefreshListViewState{
  AssetsActivityState() {
    this.initRefresh = true;
    this.disableShimmer = false;
    this.initData = true;
  }
}
