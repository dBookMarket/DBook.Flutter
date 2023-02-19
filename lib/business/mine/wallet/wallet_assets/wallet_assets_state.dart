import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class WalletAssetsState extends BaseState{
  RefreshController refreshController = RefreshController(initialRefresh: false);
  final defaultBalance = "--";
  final polygonMainBalance = "--".obs;
  final polygonTokenBalance = "--".obs;

  final bscMainBalance = "--".obs;
  final bscTokenBalance = "--".obs;

  WalletAssetsState() {
  }
}