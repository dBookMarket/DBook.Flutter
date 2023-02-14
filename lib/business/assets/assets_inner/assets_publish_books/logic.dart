import '../../../../common/entities/issues_entity.dart';
import '../../../../common/widgets/refresh_list_view/logic.dart';
import '../../../service_api/base/net_work.dart';
import 'state.dart';

class AssetsPublishBooksLogic extends RefreshListViewLogic<IssuesEntity>  {
  final AssetsPublishBooksState refreshState = AssetsPublishBooksState();

  @override
  Future<List<IssuesEntity>?> loadData({int? pageNum}) async{
    return NetWork.getInstance().assets.issueUser(authorId: refreshState.authorId,page: pageNum);
  }
}
