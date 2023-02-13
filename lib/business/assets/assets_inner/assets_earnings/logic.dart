import '../../../../common/entities/transactions_list_entity.dart';
import '../../../../common/widgets/refresh_list_view/logic.dart';
import '../../../service_api/base/net_work.dart';
import 'state.dart';

class AssetsEarningsLogic extends RefreshListViewLogic<TransactionsListEntity> {
  bool isCurrent = false;
  final AssetsEarningsState refreshState = AssetsEarningsState();

  AssetsEarningsLogic({required this.isCurrent});

  @override
  Future<List<TransactionsListEntity>?> loadData({int? pageNum}) async {
    return NetWork.getInstance().market.transactions(isCurrent: isCurrent);
  }
}
