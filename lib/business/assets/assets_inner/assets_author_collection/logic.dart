import '../../../../common/entities/collection_entity.dart';
import '../../../../common/widgets/refresh_list_view/logic.dart';
import '../../../service_api/base/net_work.dart';
import 'state.dart';

class AssetsAuthorCollectionLogic extends RefreshListViewLogic<CollectionEntity>  {
  final AssetsAuthorCollectionState refreshState = AssetsAuthorCollectionState();

  @override
  Future<List<CollectionEntity>?> loadData({int? pageNum}) async{
    return NetWork.getInstance().assets.assetsUser(userId: refreshState.authorId,page: pageNum);
  }
}
