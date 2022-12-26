import 'package:dbook/common/entities/trend_list_entity.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/refresh_list_view/logic.dart';
import '../../../service_api/base/net_work.dart';
import 'secondary_market_trend_state.dart';

class SecondaryMarketTrendLogic extends RefreshListViewLogic<TrendListEntity> {
  final SecondaryMarketTrendState refreshState = SecondaryMarketTrendState();

  @override
  Future<List<TrendListEntity>?> loadData({int? pageNum}) async {
    // return [
    //   {"date":"2022-12-02","quantities":1},
    //   {"date":"2022-12-03","quantities":2},
    //   {"date":"2022-12-05","quantities":5},
    //   {"date":"01/04","quantities":4},
    //   {"date":"01/05","quantities":2},
    //   {"date":"01/06","quantities":3},
    //   {"date":"01/07","quantities":7},
    //   {"date":"01/08","quantities":4321}
    // ].map((e) => TrendListEntity.fromJson({"date":e['date'],"quantities":e['quantities']})).toList();
    return NetWork.getInstance().market.trendList(issueId: refreshState.issuesInfo.id ?? '');
  }
}
