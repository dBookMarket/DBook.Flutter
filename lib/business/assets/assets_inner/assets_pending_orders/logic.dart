import 'package:dbook/business/assets/assets_inner/assets_pending_orders/state.dart';
import '../../../../common/entities/collection_entity.dart';
import '../../../../common/widgets/refresh_list_view/logic.dart';
import '../../../service_api/base/net_work.dart';

class AssetsPendingOrdersLogic extends RefreshListViewLogic<CollectionEntity>  {
  final AssetsPendingOrdersState refreshState = AssetsPendingOrdersState();

  @override
  Future<List<CollectionEntity>?> loadData({int? pageNum}) {
    return NetWork.getInstance().market.pendingOrders();
  }
}

