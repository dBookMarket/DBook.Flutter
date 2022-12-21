import 'package:dbook/common/widgets/refresh_list_view/state.dart';
import 'package:dbook/common/widgets/view_state/view_state.dart';

class SearchResultState extends RefreshListViewState{
  String? searchKey;

  SearchResultState() {
    this.initRefresh = false;
    this.disableShimmer = true;
    this.initData = false;
  }
}
