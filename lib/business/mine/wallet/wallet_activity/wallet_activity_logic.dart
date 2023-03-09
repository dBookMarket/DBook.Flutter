import 'package:dbook/common/store/order.dart';
import '../../../../common/entities/transactions_list_entity.dart';
import '../../../../common/widgets/refresh_list_view/logic.dart';
import 'wallet_activity_state.dart';

class WalletActivityLogic extends RefreshListViewLogic<TransactionsListEntity>  {
  final WalletActivityState refreshState = WalletActivityState();

  @override
  Future<List<TransactionsListEntity>?> loadData({int? pageNum}) async{
    await OrderStore.to.refreshPendingOrder();
    return OrderStore.to.orderList;
  }

  @override
  void onInit() {
    super.onInit();
    OrderStore.to.refreshPendingOrder();
  }
}
