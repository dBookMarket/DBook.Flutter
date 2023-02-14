import 'package:dbook/common/widgets/refresh_list_view/state.dart';

class SearchResultState extends RefreshListViewState{
  String? searchKey;

  SearchResultState() {
    this.initRefresh = true;
    this.disableShimmer = false;
    this.initData = false;
  }
}
