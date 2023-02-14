import '../../../../common/entities/issues_entity.dart';
import '../../../../common/widgets/refresh_list_view/logic.dart';
import '../../../service_api/base/net_work.dart';
import 'state.dart';

class AssetsShelvedLogic extends RefreshListViewLogic<IssuesEntity>  {
  final AssetsShelvedState refreshState = AssetsShelvedState();

  @override
  Future<List<IssuesEntity>?> loadData({int? pageNum}) async{
    return NetWork.getInstance().assets.issueCurrent(page: pageNum);
  }

  delete(id)async{
    refreshState.setBusy();
    await NetWork.getInstance().assets.deleteIssue(id: id.toString()).onError((error, stackTrace) => refreshState.setError(t: 'delete failed'));
    refreshState.setSuccess(t: 'success');
    refreshState.list.removeWhere((element) => element.id == id);
  }
}
