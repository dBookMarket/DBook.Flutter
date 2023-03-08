import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:dbook/common/store/socket.dart';
import 'package:dbook/common/store/trade.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:get/get.dart';

import '../../../common/services/global_time.dart';
import '../../service_api/base/net_work.dart';
import '../issues_state.dart';
import 'issues_detail_state.dart';

class IssuesDetailLogic extends FullLifeCycleController with FullLifeCycleMixin{
  final IssuesDetailState state = IssuesDetailState();

  getBookDetail({bool enableLoad = true}) async {
    if(!state.alive) return;
    if(enableLoad) state.setBusy();
    state.issuesInfo.value = await NetWork.getInstance().assets.issueDetail(issueId: state.issuesId).onError((error, stackTrace) => state.setError(t: 'load issue failed'));
    refresh();
    if(enableLoad) state.setIdle();
  }

  // 手动刷新 在售->售罄
  refresh() async {
    if(state.issuesInfo.value.status != IssuesStatus.on_sale.name) {
      return;
    }
    DateTime? endTime = DateUtil.getDateTime(state.issuesInfo.value.publishedAt ?? '')?.add(DateTime.now().timeZoneOffset).add(Duration(minutes: state.issuesInfo.value.duration ?? 0));
    DateTime? cTime = DateUtil.getDateTimeByMs(GlobalTimeService.to.globalTime.value);
    Duration countDown = endTime?.difference(cTime) ?? Duration();
    if (countDown.inSeconds >= 0) {
      return;
    }
    await Future.delayed(Duration(minutes: 1));
    print('on_sale->off_sale:手动刷新了一遍1${state.issuesInfo.value.status}');
    getBookDetail(enableLoad: false);
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
        print('pre_sale->on_sale:手动刷新了一遍'),
              getBookDetail(),
            });
      } else if (state.issuesInfo.value.status == IssuesStatus.on_sale.name) {
        state.issuesInfo.value.status = IssuesStatus.unsold.name;

        Future.delayed(Duration(seconds: 1)).then((value) => {
              state.issuesInfo.refresh(),
          print('on_sale->unsold:手动刷新了一遍'),
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

  amountAdd() {
    if (state.buyAmount.value < (state.issuesInfo.value.buyLimit ?? 1)-(state.issuesInfo.value.nOwned??0)) {
      state.buyAmount.value++;
    }
  }

  amountSub() {
    if (state.buyAmount.value > 1) {
      state.buyAmount.value--;
    }
  }

  buy() async {
    var price = state.issuesInfo.value.price ?? 0.0;
    var result = await TradeStore.to.buyPrimaryMarket(publicChain: state.issuesInfo.value.token?.blockChain, amount: state.buyAmount.value, price: price);
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
    state.setSuccess(t: 'pay success');
  }

  socketListen(){
    logX.d('IssuesDetailLogic>>>设置监听');
    SocketStore.to.onChanged.listen((event)=>{getBookDetail(enableLoad: false),print('socketListen:手动刷新了一遍')});
  }

  @override
  void onInit() {
    getBookDetail();
    socketListen();
    super.onInit();
  }

  @override
  void onDetached() {
  }

  @override
  void onInactive() {
  }

  @override
  void onPaused() {
  }

  @override
  void onResumed() {
    print('onResumed:手动刷新了一遍');
    getBookDetail(enableLoad: false);
  }

  @override
  void onClose() {
    state.alive = false;
    super.onClose();
  }
}
