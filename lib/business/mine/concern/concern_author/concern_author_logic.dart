import 'package:dbook/common/entities/fans_entity.dart';

import '../../../../common/widgets/refresh_list_view/logic.dart';
import '../../../service_api/base/net_work.dart';
import 'concern_author_state.dart';

class ConcernAuthorLogic extends RefreshListViewLogic<FansEntity>  {
  final ConcernAuthorState refreshState = ConcernAuthorState();

  @override
  Future<List<FansEntity>?> loadData({int? pageNum}) {
    return NetWork.getInstance().user.fansCurrent(page: pageNum);
  }
}
