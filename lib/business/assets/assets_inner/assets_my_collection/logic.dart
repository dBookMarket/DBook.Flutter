import 'package:dbook/business/assets/assets_inner/assets_my_collection/state.dart';
import 'package:dbook/common/entities/collection_entity.dart';

import '../../../../common/widgets/refresh_list_view/logic.dart';
import '../../../service_api/base/net_work.dart';

class AssetsMyCollectionLogic extends RefreshListViewLogic<CollectionEntity>  {
  final AssetsMyCollectionState refreshState = AssetsMyCollectionState();

  @override
  Future<List<CollectionEntity>?> loadData({int? pageNum}) {
    return NetWork.getInstance().assets.assetsCurrent();
  }

  delete(id)async{
    refreshState.setBusy();
    await NetWork.getInstance().assets.deleteDraft(id: id.toString()).onError((error, stackTrace) => refreshState.setError(t: 'delete failed'));
    refreshState.setIdle();
    refreshState.list.removeWhere((element) => element.id == id);
  }
}
