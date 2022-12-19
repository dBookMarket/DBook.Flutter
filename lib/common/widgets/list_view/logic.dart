import 'package:dbook/common/widgets/list_view/state.dart';
import 'package:get/get.dart';

abstract class ListViewLogic<T> extends GetxController {
  late final ListViewState state;


  @override
  void onReady() {
    super.onReady();
  }

  Future<List<T>?> loadData();

  onCompleted(List data,{bool? isRefresh}) {}


}
