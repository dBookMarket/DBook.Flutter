import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:get/get.dart';

import 'state.dart';

class WritingLogic extends GetxController {
  final WritingState state = WritingState();


  save(){
    state.setBusy();
    NetWork.getInstance().assets.saveDraft(title: '',content: '').onError((error, stackTrace) => state.setError(t: 'upload failed'));
    state.setIdle();
  }
}
