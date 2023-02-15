import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:get/get.dart';

class AdsIssuesState extends BaseState{
  final list = [].obs;
  final _currentIndex = 0.obs;

  set currentIndex(val) =>  _currentIndex.value = val;
  get currentIndex =>  _currentIndex.value;
  AdsIssuesState() {
    ///Initialize variables
  }
}
