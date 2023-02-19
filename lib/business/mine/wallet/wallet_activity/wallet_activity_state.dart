import '../../../../common/widgets/refresh_list_view/state.dart';

class WalletActivityState extends RefreshListViewState{
  WalletActivityState() {
    this.initRefresh = true;
    this.disableShimmer = false;
    this.initData = true;
  }
}