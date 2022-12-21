import 'package:dbook/common/entities/issues_entity.dart';
import 'package:get/get.dart';

import '../../../common/widgets/refresh_list_view/logic.dart';
import '../../service_api/base/net_work.dart';
import 'search_result_state.dart';

class SearchResultLogic extends RefreshListViewLogic<IssuesEntity> {
  final SearchResultState refreshState = SearchResultState();

  @override
  Future<List<IssuesEntity>?> loadData({int? pageNum}) async{
    return NetWork.getInstance().assets.search(search: refreshState.searchKey??'');
  }

  search(String key){
    refreshState.searchKey = key;
    if(key.isEmpty) return;
    refresh();
  }


}
