import '../../../../common/entities/concern_opus_entity.dart';
import '../../../../common/widgets/refresh_list_view/logic.dart';
import '../../../service_api/base/net_work.dart';
import 'concern_opus_state.dart';

class ConcernOpusLogic extends RefreshListViewLogic<ConcernOpusEntity>  {
  final ConcernOpusState refreshState = ConcernOpusState();

  @override
  Future<List<ConcernOpusEntity>?> loadData({int? pageNum}) async{
    return NetWork.getInstance().assets.wishList(page: pageNum);
  }
}
