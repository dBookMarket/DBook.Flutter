import '../../../../common/entities/book_entity.dart';
import '../../../../common/widgets/refresh_list_view/logic.dart';
import '../../../service_api/base/net_work.dart';
import 'state.dart';

class AssetsPendingLogic extends RefreshListViewLogic<BookEntity>  {
  final AssetsPendingState refreshState = AssetsPendingState();

  @override
  Future<List<BookEntity>?> loadData({int? pageNum}) async{
    List<BookEntity> books = await NetWork.getInstance().assets.bookList(page: pageNum);
    return books.where((e) => !(e.hasIssued??false)).toList();
  }

  delete(id)async{
    refreshState.setBusy();
    await NetWork.getInstance().assets.deleteBook(id: id.toString()).onError((error, stackTrace) => refreshState.setError(t: 'delete failed'));
    refreshState.setIdle();
    refreshState.list.removeWhere((element) => element.id == id);
  }
}
