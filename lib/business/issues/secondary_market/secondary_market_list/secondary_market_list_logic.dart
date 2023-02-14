import 'package:dbook/common/entities/trades_list_entity.dart';

import '../../../../common/widgets/refresh_list_view/logic.dart';
import '../../../service_api/base/net_work.dart';
import 'secondary_market_list_state.dart';

class SecondaryMarketListLogic extends RefreshListViewLogic<TradesListEntity> {
  final SecondaryMarketListState refreshState = SecondaryMarketListState();

  @override
  Future<List<TradesListEntity>?> loadData({int? pageNum}) async {
    return NetWork.getInstance().market.trades(issueId: refreshState.issuesInfo.id ?? '',page:pageNum);
  }
}
