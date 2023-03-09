import 'dart:convert';

import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/store/overlay.dart';
import 'package:dbook/common/store/socket.dart';
import 'package:get/get.dart';

import '../entities/transactions_list_entity.dart';
import '../services/storage.dart';
import '../utils/logger.dart';
import '../values/storage.dart';

enum OrderStatus {
  pending,
  success,
  failed,
}

class OrderStore extends GetxController {
  static OrderStore get to => Get.find();

  final orderList = <TransactionsListEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _orderListener();
    getOrder();
  }

  _orderListener() {
    SocketStore.to.onChanged.listen((event) => refreshPendingOrder());
    orderList.listen((event) {
      var pending = orderList.where((element) => element.status == OrderStatus.pending.name).toList();
      logX.d('是否展示order pending >>>>>${pending.length == 0}');
      if(pending.length == 0) {
        OverlayStore.to.hideFloating();
      }else{
        OverlayStore.to.showFloating();
      }
    });
  }

  saveOrder(TransactionsListEntity order) {
    orderList.insert(0, order);
    StorageService.to.setString(ORDER_KEY_STR, jsonEncode(orderList.toJson()));
  }

  saveAllToLocal(){
    StorageService.to.setString(ORDER_KEY_STR, jsonEncode(orderList.toJson()));
  }

  getOrder() {
    var profileOffline = StorageService.to.getString(ORDER_KEY_STR);
    if (profileOffline.isEmpty) return;
    List<TransactionsListEntity>? info;
    try {
      info = (jsonDecode(profileOffline) as List).map((value) => TransactionsListEntity.fromJson(value)).toList();
      logX.d('本地交易数据>>>>>$info');
    } catch (e) {
      logX.e(e, profileOffline);
    }
    if (info == null || info.length == 0) return;
    orderList.addAll(info);
    refreshPendingOrder();
  }

  refreshPendingOrder() async{
    List<TransactionsListEntity> pending = orderList.where((element) => element.status == OrderStatus.pending.name).toList();
    if(pending.length == 0) {
      return;
    }

    List<TransactionsListEntity> transaction = await NetWork.getInstance().market.transactionsCurrent(page: 1);

    pending.forEach((p) {
      TransactionsListEntity tx = transaction.firstWhere((element2) => element2.id == p.id, orElse: () => TransactionsListEntity());
      print('状态>>>>>${tx.status}');
      if(tx.status == OrderStatus.pending.name) return;

      var index = orderList.indexWhere((element) => element.id == p.id);
      print('状态1>>>>>$index ${orderList.map((element) => element.id == p.id).toList()} ${p.id}');
      if(index == -1) return;
      orderList[index].status = tx.status;
      orderList[index].hash = tx.hash;
      orderList.refresh();
      saveAllToLocal();
    });

  }
}
