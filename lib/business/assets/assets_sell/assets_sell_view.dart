import 'package:dbook/business/issues/issues_detail/issues_detail_view.dart';
import 'package:dbook/common/utils/string_helper.dart';
import 'package:dbook/common/values/colors.dart';
import 'package:dbook/common/values/fontSize.dart';
import 'package:dbook/common/widgets/button.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/config/app_config.dart';
import '../../../common/widgets/input.dart';
import '../../../common/widgets/number_controller.dart';
import 'assets_sell_logic.dart';

class AssetsSellPage extends StatelessWidget {
  final logic = Get.put(AssetsSellLogic());
  final state = Get.find<AssetsSellLogic>().state;

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
    return Obx(() {
      var range =
          '${removeZero((state.issuesInfo.value.priceRange?.maxPrice! ?? '0').toString())} USDC/${removeZero((state.issuesInfo.value.priceRange?.minPrice! ?? '0').toString())} USDC';
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: TextX(state.isEdit?'Edit':'Sell', fontSize: FontSizeX.s16, color: ColorX.txtTitle),
            width: 1.sw,
            margin: EdgeInsets.symmetric(vertical: 40.h),
          ),
          _title('Book title'),
          TextX(state.issuesInfo.value.book?.title, fontSize: FontSizeX.s13, color: ColorX.txtTitle),
          SizedBox(height: 30.h),
          _title('Current minimum/maximum price'),
          Row(
            children: [
              TextX(range, fontSize: FontSizeX.s13, color: ColorX.txtTitle),
              Spacer(),
              InkWell(
                child: TextX('Detail',
                    style: TextStyle(
                        fontSize: FontSizeX.s13,
                        color: ColorX.txtBrown,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationColor: ColorX.txtBrown)),
                onTap: () => _onClick('detail'),
              )
            ],
          ),
          SizedBox(height: 30.h),
          _title('Selling Price'),
          SizedBox(height: 10.h),
          _input(),
          SizedBox(height: 30.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title('Purchase quantity'),
                  TextX('You have：${state.issuesInfo.value.nOwned??0}', fontSize: FontSizeX.s13, color: ColorX.txtTitle),
                ],
              )),
              NumberControllerWidget(
                max: state.issuesInfo.value.nOwned,
                min: 1,
                numText: state.defaultQuantity,
                updateValueChanged: (num)=>logic.updateQuantity(num),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Row(children: [
            Spacer(),
            Obx(() {
              var royalty = state.issuesInfo.value.royalty == null?'-':removeZero((state.issuesInfo.value.royalty).toString());
              return TextX('Author Royalties：$royalty%', color: ColorX.txtHint, fontSize: FontSizeX.s11);
            }),
            SizedBox(width: 40.w),
            TextX('Platform Royalty：${RoyaltyConfig.platform}', color: ColorX.txtHint, fontSize: FontSizeX.s11),
          ]),
          SizedBox(height: 20.h),
          _action(),
          SizedBox(height: 30.h),
        ],
      );
    });
  }

  Widget _action() => Row(children: [
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
            child: ButtonX(state.isEdit?'Commit':'Sell',
                borderRadius: 0,
                backgroundColor: ColorX.buttonBrown,
                textColor: ColorX.txtYellow,
                fontSize: FontSizeX.s13,
                padding: EdgeInsets.symmetric(vertical: 24.h),
                onPressed: () => _onClick('Sell'))),
      ]);

  Widget _input() => Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r), border: Border.all(width: 1.r, color: Colors.black)),
        child: InputWidget(
          hint: 'Please enter the selling price',
          controller: state.priceController,
          style: TextStyle(color: ColorX.txtTitle, fontSize: FontSizeX.s11),
          hintStyle: TextStyle(color: ColorX.txtHint, fontSize: FontSizeX.s11),
          autofocus: false,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))],
          textInputAction: TextInputAction.done,
        ),
      );

  Widget _title(String? title) => Container(
        margin: EdgeInsets.only(bottom: 10.h),
        child: TextX(title, fontSize: FontSizeX.s13, color: ColorX.txtHint),
      );

  _onClick(type) {
    switch (type) {
      case 'detail':
        Get.to(() => IssuesDetailPage(), arguments: {'detail': state.issuesInfo.value});
        break;
      case 'empty':
        FocusScope.of(Get.context!).requestFocus(FocusNode());
        break;
      case 'Cancel':
        Get.back();
        break;
      case 'Sell':
        logic.sell();
        break;
    }
  }
}
