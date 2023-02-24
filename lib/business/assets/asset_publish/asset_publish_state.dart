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
  TextEditingController countController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController univalentController = TextEditingController();
  //版税
  TextEditingController royaltiesController = TextEditingController();
  TextEditingController periodController = TextEditingController();
  TextEditingController limitController = TextEditingController();

  final publicChainList = [PublicChainType.polygon.name,PublicChainType.bnb.name];

  final publicChain = PublicChainType.bnb.name.obs;
  final publishTime = Rx<DateTime?>(null);
  final buttonValid = false.obs;

  AssetPublishState() {
    issueInfo = Get.arguments?['issueInfo'];
    logX.d('revise>>>>>>${issueInfo?.token}');
    if(issueInfo!=null){
      bookInfo = BookEntity.fromJson(issueInfo!.book?.toJson()??{});
      countController.text = issueInfo!.quantity.toString();
      currencyController.text = issueInfo!.token?.currency??'';
      univalentController.text = issueInfo?.price.toString()??'';
      royaltiesController.text = issueInfo?.royalty.toString()??'';
      periodController.text = issueInfo?.duration.toString()??'';
      limitController.text = issueInfo?.buyLimit.toString()??'';
      publicChain.value = issueInfo?.token?.blockChain.toString()??'';
      publishTime.value = DateUtil.getDateTime(issueInfo?.publishedAt??'')?.add(DateTime.now().timeZoneOffset);
    }else{
      bookInfo = Get.arguments?['bookInfo'];
      countController.text = '1';
      currencyController.text = 'USDC';
      univalentController.text = '1';
      royaltiesController.text = '1';
      periodController.text = '60';
      limitController.text = '1';
    }


  }
}
