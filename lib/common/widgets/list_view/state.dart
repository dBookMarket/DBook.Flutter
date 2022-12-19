
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../view_state/view_state.dart';

class ListViewState<T> extends BaseState{
  /// 分页第一页页码
  final int pageNumFirst = 1;
  /// 分页条目数量
  int pageSize = 10;
  /// 页面数据
  final list = <T>[].obs;
  ///第一次加载
  bool firstInit = true;



  ListViewState() {
    ///Initialize variables
  }
}
