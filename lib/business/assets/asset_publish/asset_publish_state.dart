import 'package:common_utils/common_utils.dart';
import 'package:dbook/common/store/web3.dart';
import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../common/entities/book_entity.dart';
import '../../../common/entities/issues_entity.dart';
import '../../../common/utils/logger.dart';


class AssetPublishState extends BaseState{
  late BookEntity? bookInfo;
  late IssuesEntity? issueInfo;
  //数量
  TextEditingController countController = TextEditingController();
  //单价
  TextEditingController univalentController = TextEditingController();
  //版税
  TextEditingController royaltiesController = TextEditingController();
  //周期
  TextEditingController periodController = TextEditingController();
  //限购
  TextEditingController limitController = TextEditingController();

  final countLegal = true.obs;
  final royaltiesLegal = true.obs;
  final periodLegal = true.obs;
  final limitLegal = true.obs;

  final publicChainList = [PublicChainType.polygon.name,PublicChainType.bnb.name];
  final coinTypeList = [CoinType.usdc.name];

  final publicChain = PublicChainType.polygon.name.obs;
  final coinType = CoinType.usdc.name.obs;
  final publishTime = Rx<DateTime?>(null);
  final buttonValid = false.obs;

  AssetPublishState() {
    issueInfo = Get.arguments?['issueInfo'];
    logX.d('revise>>>>>>${issueInfo?.token}');
    if(issueInfo!=null){
      bookInfo = BookEntity.fromJson(issueInfo!.book?.toJson()??{});
      countController.text = issueInfo!.quantity.toString();
      univalentController.text = issueInfo?.price.toString()??'';
      royaltiesController.text = issueInfo?.royalty.toString()??'';
      periodController.text = issueInfo?.duration.toString()??'';
      limitController.text = issueInfo?.buyLimit.toString()??'';
      publicChain.value = issueInfo?.token?.blockChain.toString()??'';
      coinType.value = issueInfo?.token?.currency.toString()??'';
      publishTime.value = DateUtil.getDateTime(issueInfo?.publishedAt??'')?.add(DateTime.now().timeZoneOffset);
    }else{
      bookInfo = Get.arguments?['bookInfo'];
      countController.text = '';
      univalentController.text = '';
      royaltiesController.text = '';
      periodController.text = '';
      limitController.text = '';
    }


  }
}
