import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/config/app_config.dart';
import '../../../common/utils/string_helper.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fontSize.dart';
import '../../../common/widgets/button.dart';
import '../../../common/widgets/number_controller.dart';
import '../../../common/widgets/text.dart';
import '../../../common/widgets/view_state/base_container_view.dart';
import 'issue_buy_logic.dart';

class IssueBuyPage extends StatelessWidget {
  final logic = Get.put(IssueBuyLogic());
  final state = Get
      .find<IssueBuyLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: BaseContainer(
          viewState: state.viewState,
          background: Colors.transparent,
          child: Column(
            children: [
              Expanded(
                  child: InkWell(
                      child: Container(color: ColorX.primaryBlack.withOpacity(0.5)), onTap: () => _onClick('empty'))),
              Container(
                child: _body(),
                padding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: ColorX.primaryBackground,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r))),
              )
            ],
          )),
    );
  }

  Widget _body() {
    var price = '${removeZero((state.tradeInfo.price ?? '0').toString())} USDC';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: TextX('Buy', fontSize: FontSizeX.s16, color: ColorX.txtTitle),
          width: 1.sw,
          margin: EdgeInsets.symmetric(vertical: 40.h),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title('Selling Price'),
              TextX(price, fontSize: FontSizeX.s13, color: ColorX.txtTitle),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _title('Stock'),
              TextX(state.tradeInfo.quantity.toString(), fontSize: FontSizeX.s13, color: ColorX.txtTitle),
            ],
          )
        ]),
        SizedBox(height: 30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _title('Purchase quantity'),
            NumberControllerWidget(
              max: state.tradeInfo.quantity,
              min: 1,
              numText: state.defaultQuantity,
              updateValueChanged: (num) => logic.updateQuantity(num),
            ),
          ],
        ),
        SizedBox(height: 60.h),
        Row(children: [
          Spacer(),
          Obx(() {
            return TextX('Author Royalties：${removeZero(state.royalty.value.toString())}%', color: ColorX.txtHint, fontSize: FontSizeX.s11);
          }),
          SizedBox(width: 40.w),
          TextX('Platform Royalty：${RoyaltyConfig.platform}', color: ColorX.txtHint, fontSize: FontSizeX.s11),
        ]),
        SizedBox(height: 20.h),
        _action(),
        SizedBox(height: 30.h),
      ],
    );
  }

  Widget _action() =>
      Row(children: [
        Expanded(
          child: ButtonX('Cancel',
              borderRadius: 0,
              backgroundColor: ColorX.buttonYellow,
              textColor: ColorX.txtBrown,
              fontSize: FontSizeX.s13,
              padding: EdgeInsets.symmetric(vertical: 24.h),
              onPressed: () => _onClick('Cancel')),
        ),
        SizedBox(width: 50.w),
        Expanded(
            child: ButtonX('Buy',
                borderRadius: 0,
                backgroundColor: ColorX.buttonBrown,
                textColor: ColorX.txtYellow,
                fontSize: FontSizeX.s13,
                padding: EdgeInsets.symmetric(vertical: 24.h),
                onPressed: () => _onClick('Buy'))),
      ]);

  Widget _title(String? title) =>
      Container(
        margin: EdgeInsets.only(bottom: 10.h),
        child: TextX(title, fontSize: FontSizeX.s13, color: ColorX.txtHint),
      );

  _onClick(type) {
    switch (type) {
      case 'empty':
        FocusScope.of(Get.context!).requestFocus(FocusNode());
        break;
      case 'Cancel':
        Get.back();
        break;
      case 'Buy':
        logic.buy();
        break;
    }
  }
}
