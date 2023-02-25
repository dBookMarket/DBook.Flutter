import 'package:dbook/business/assets/assets_inner/assets_pending_orders/state.dart';
import '../../../../common/entities/pending_order_entity.dart';
import '../../../../common/widgets/refresh_list_view/logic.dart';
import '../../../service_api/base/net_work.dart';

class AssetsPendingOrdersLogic extends RefreshListViewLogic<PendingOrderEntity>  {
  final AssetsPendingOrdersState refreshState = AssetsPendingOrdersState();

  @override
  Future<List<PendingOrderEntity>?> loadData({int? pageNum}) {
    return NetWork.getInstance().market.pendingOrders(page: pageNum);
  }


  delete(id)async{
    refreshState.setBusy();
    await NetWork.getInstance().market.cancelTrade(tradeId: id).onError((error, stackTrace) => refreshState.setError(t: 'delete failed'));
    refreshState.setIdle();
    refresh();
  }
}

