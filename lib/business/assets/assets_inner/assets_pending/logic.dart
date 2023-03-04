import 'package:dbook/common/utils/logger.dart';

import '../../../../common/entities/book_entity.dart';
import '../../../../common/widgets/refresh_list_view/logic.dart';
import '../../../service_api/base/net_work.dart';
import 'state.dart';

class AssetsPendingLogic extends RefreshListViewLogic<BookEntity> {
  final AssetsPendingState refreshState = AssetsPendingState();

  @override
  Future<List<BookEntity>?> loadData({int? pageNum}) async {
    List<BookEntity> books = await NetWork.getInstance().assets.bookList(page: pageNum);
    var list = books.where((e) => !(e.hasIssued ?? false)).toList();
    _timedRefresh(list);
    return list;
  }

  delete(id) async {
    refreshState.setBusy();
    await NetWork.getInstance().assets.deleteBook(id: id.toString()).onError((error, stackTrace) => refreshState.setError(t: 'delete failed'));
    refreshState.setIdle();
    refreshState.list.removeWhere((element) => element.id == id);
  }

  _timedRefresh(list) {
    var index = list.indexWhere((element) => element.status != 'success');
    if (index != -1) {
      logX.d('执行延时刷新');
      Future.delayed(Duration(seconds: 60), () {
        refresh();
      });
    }
  }
}
