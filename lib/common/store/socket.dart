import 'dart:async';
import 'dart:convert';

import 'package:dbook/common/store/store.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

import '../../business/service_api/base/api_constants.dart';

class SocketStore extends GetxController {
  static SocketStore get to => Get.find();
  IOWebSocketChannel? channel;
  bool isConnect = false;
  StreamController<List> _resultListener = StreamController.broadcast();
  late Stream onChanged;

  @override
  void onInit() {
    onChanged = _resultListener.stream;
    super.onInit();
  }

  init(){
    var token = UserStore.to.token;
    if(token.isEmpty){
      return;
    }
    var baseUri = Uri.parse(ApiConstants.BASE_URL);
    var socketUri = Uri.parse('ws://${baseUri.host}:${baseUri.port}/ws/notifications?token=${UserStore.to.token}');
    logX.d('初始化socket>>>>$socketUri');
    channel = new IOWebSocketChannel.connect(socketUri);
    channel?.stream.listen((event) {
      _resultListener.add(['refresh']);
      print('socket-stream>>>$event');
    }).onError((e){
      print('socket-err>>>$e');
      Future.delayed(Duration(seconds: 10)).then((value) => _reconnect());
    });
  }


  _sendMessage(msg) {
    print('socket发送消息>>>>${jsonEncode(msg)}');
    channel?.sink.add(jsonEncode(msg));
  }

  _sendHeart() {
    Map<String, dynamic> params = Map();
    params['msgType'] = 'ping';
    _sendMessage(params);
  }

  _reconnect() {
    logX.d('socket重新连接>>>>');
    init();
  }

}
