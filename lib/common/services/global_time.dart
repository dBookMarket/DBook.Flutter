import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';

import '../utils/logger.dart';

class GlobalTimeService extends GetxService {
  static GlobalTimeService get to => Get.find();

  final globalTime = (-1).obs;
  late Timer timer;

  Future<GlobalTimeService> init() async {
    timers();
    return this;
  }

  timers() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (globalTime.value != -1) {
        globalTime.value += 1000;
        // logX.d('同步本地时间--自增>>>>${globalTime.value}');
      }
    });
  }

  resetTime(int time) {
    globalTime.value = time;
    timer.cancel();
    timers();
    logX.d('同步本地时间>>>>$time ${DateUtil.formatDateMs(time)}');
  }
}
