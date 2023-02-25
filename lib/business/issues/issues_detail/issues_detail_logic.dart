import 'package:common_utils/common_utils.dart';
import 'package:dbook/common/store/web3.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:get/get.dart';

import '../../../common/services/global_time.dart';
import '../../service_api/base/net_work.dart';
import '../issues_state.dart';
import 'issues_detail_state.dart';

class IssuesDetailLogic extends GetxController {
  final IssuesDetailState state = IssuesDetailState();

  getBookDetail() async {
    state.setBusy();
    state.issuesInfo.value = await NetWork.getInstance().assets.issueDetail(issueId: state.issuesId).onError((error, stackTrace) => state.setError(t: 'load issue failed'));
    logX.d('args>>>>>>${Get.arguments}');
    Get.currentRoute;
    state.setIdle();
  }

  Duration comingTime() {
    Duration countDown = Duration();
    DateTime? endTime;
    if (state.issuesInfo.value.status == IssuesStatus.pre_sale.name) {
      endTime = DateUtil.getDateTime(state.issuesInfo.value.publishedAt ?? '')?.add(DateTime.now().timeZoneOffset);
    } else if (state.issuesInfo.value.status == IssuesStatus.on_sale.name) {
      endTime = DateUtil.getDateTime(state.issuesInfo.value.publishedAt ?? '')?.add(DateTime.now().timeZoneOffset).add(Duration(minutes: state.issuesInfo.value.duration ?? 0));
    } else {
      return Duration();
    }

    DateTime? cTime = DateUtil.getDateTimeByMs(GlobalTimeService.to.globalTime.value);
    countDown = endTime?.difference(cTime) ?? Duration();
    if (countDown.inSeconds < 0) {
      return Duration();
    }

    if (countDown.inSeconds == 0) {
      if (state.issuesInfo.value.status == IssuesStatus.pre_sale.name) {
        state.issuesInfo.value.status = IssuesStatus.on_sale.name;
        Future.delayed(Duration(seconds: 1)).then((value) => {
              state.issuesInfo.refresh(),
              getBookDetail(),
            });
      } else if (state.issuesInfo.value.status == IssuesStatus.on_sale.name) {
        state.issuesInfo.value.status = IssuesStatus.unsold.name;

        Future.delayed(Duration(seconds: 1)).then((value) => {
              state.issuesInfo.refresh(),
              getBookDetail(),
            });
      }
      return Duration();
    }
    return countDown;
  }

  String countDownAdd0(int value) {
    String valueStr;
    if (value < 0) {
      valueStr = '00';
    } else if (value < 10) {
      valueStr = '0$value';
    } else {
      valueStr = value.toString();
    }
    return valueStr;
  }

  wish() async {
    var wish = state.issuesInfo.value.isWished ?? false;
    state.setBusy();

    var result = !wish;
    await NetWork.getInstance()
        .assets
        .wish(issue: state.issuesInfo.value.id.toString(), isWish: !wish)
        .onError((error, stackTrace) => {state.setError(t: 'failed'), result = wish});
    state.issuesInfo.value.isWished = result;
    state.issuesInfo.refresh();
    state.setIdle();
  }

  Future<bool> pay() async {
    state.setBusy();
    var chainType = Web3Store.to.formatChainType(state.issuesInfo.value.token?.blockChain ?? '');
    if (chainType == null) {
      state.setError(t: 'invalid chain');
      return false;
    }
    var price = state.issuesInfo.value.price ?? 0.0;
    var result = false;
    try {
      await Web3Store.to.payFirstTrade(type: chainType, price: price, amount: state.buyAmount.value);
      result = true;
      state.setIdle();
    } catch (e) {
      logX.d(e);
      state.setError(t: 'pay failed');
      result = false;
    }

    state.setSuccess(t: 'pay success');
    return result;
  }

  amountAdd() {
    if (state.buyAmount.value < (state.issuesInfo.value.buyLimit ?? 1)) {
      state.buyAmount.value++;
    }
  }

  amountSub() {
    if (state.buyAmount.value > 1) {
      state.buyAmount.value--;
    }
  }

  buy() async {
    var result = await pay();
    if (!result) return;
    if (state.issuesInfo.value.trade == null) {
      state.setError(t: 'invalid trade id');
      return;
    }

    state.setBusy();
    await NetWork.getInstance()
        .market
        .transaction(tradeId: state.issuesInfo.value.trade?.id ?? 0, quantity: state.buyAmount.value)
        .onError((error, stackTrace) => {state.setError(t: 'buy failed'), result = false});
    state.setIdle();
  }

  @override
  void onInit() {
    getBookDetail();
    super.onInit();
  }
}
