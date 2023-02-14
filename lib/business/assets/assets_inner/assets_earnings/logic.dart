import '../../../../common/entities/transactions_list_entity.dart';
import '../../../../common/widgets/refresh_list_view/logic.dart';
import '../../../service_api/base/net_work.dart';
import '../../assets_state.dart';
import 'state.dart';

class AssetsEarningsLogic extends RefreshListViewLogic<TransactionsListEntity> {
  final AssetsEarningsState refreshState = AssetsEarningsState();


  @override
  Future<List<TransactionsListEntity>?> loadData({int? pageNum}) async {
    if(refreshState.assetsType == AssetsType.AUTHOR){
      return NetWork.getInstance().market.transactionsUser(userId: refreshState.userId,page: pageNum);
    }else{
      return NetWork.getInstance().market.transactionsCurrent(page: pageNum);
    }

  }
}
