import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';

import '../../../common/services/global_time.dart';
import '../issues_state.dart';
import 'issues_detail_state.dart';

class IssuesDetailLogic extends GetxController {
  final IssuesDetailState state = IssuesDetailState();

  getBookDetail()async{

  }


  Duration comingTime() {
    DateTime? endTime;
    if(state.issuesInfo.status == IssuesStatus.pre_sale.name){
      endTime = DateUtil.getDateTime(state.issuesInfo.publishedAt??'');
    }else if(state.issuesInfo.status == IssuesStatus.on_sale.name){
      endTime = DateUtil.getDateTime(state.issuesInfo.publishedAt??'')?.add(Duration(seconds: state.issuesInfo.duration??0));
    }else{
      return Duration();
    }

    DateTime? cTime = DateUtil.getDateTimeByMs(GlobalTimeService.to.globalTime.value);
    // endTime = endTime?.add(Duration(days: 34));
    Duration? countDown = endTime?.difference(cTime);

    if(countDown == null || countDown.inSeconds<0){
      return Duration();
    }


    return countDown;
  }

  String countDownAdd0(int value){
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
}
