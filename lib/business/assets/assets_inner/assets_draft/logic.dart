import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/entities/drafts_entity.dart';

import '../../../../common/widgets/refresh_list_view/logic.dart';
import 'state.dart';

class AssetsDraftLogic extends RefreshListViewLogic<DraftsEntity>  {
  final AssetsDraftState refreshState = AssetsDraftState();

  @override
  Future<List<DraftsEntity>?> loadData({int? pageNum}) {
    return NetWork.getInstance().assets.draftList();
  }

  delete(id)async{
    refreshState.setBusy();
    await NetWork.getInstance().assets.deleteDraft(id: id.toString()).onError((error, stackTrace) => refreshState.setError(t: 'delete failed'));
    refreshState.setIdle();
    refreshState.list.removeWhere((element) => element.id == id);
  }
}
