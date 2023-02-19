import '../../../../common/entities/concern_opus_entity.dart';
import '../../../../common/widgets/refresh_list_view/logic.dart';
import '../../../service_api/base/net_work.dart';
import 'wallet_activity_state.dart';

class WalletActivityLogic extends RefreshListViewLogic<ConcernOpusEntity>  {
  final WalletActivityState refreshState = WalletActivityState();

  @override
  Future<List<ConcernOpusEntity>?> loadData({int? pageNum}) async{
    return NetWork.getInstance().assets.wishList(page: pageNum);
  }
}
