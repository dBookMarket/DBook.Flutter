import 'package:dbook/common/entities/transactions_list_entity.dart';

import '../../../../common/widgets/refresh_list_view/logic.dart';
import '../../../service_api/base/net_work.dart';
import 'secondary_market_activity_state.dart';

class SecondaryMarketActivityLogic extends RefreshListViewLogic<TransactionsListEntity> {
  final SecondaryMarketActivityState refreshState = SecondaryMarketActivityState();

  @override
  Future<List<TransactionsListEntity>?> loadData({int? pageNum}) async {
    return NetWork.getInstance().market.transactions(issueId: refreshState.issuesInfo.id ?? '',isCurrent: false);
  }
}
