import 'package:common_utils/common_utils.dart';
import 'package:dbook/common/config/app_config.dart';
import 'package:dbook/common/values/colors.dart';
import 'package:dbook/common/values/fontSize.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/button.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_picker/picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/services/global_time.dart';
import 'asset_publish_logic.dart';

class AssetPublishPage extends StatelessWidget {
  final logic = Get.put(AssetPublishLogic());
  final state = Get
      .find<AssetPublishLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Listing settings'),
      body: BaseContainer(
        viewState: state.viewState,
        child: _body(),
      ),
    );
  }

  Widget _body() =>
      SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 30.h),
        child: Obx(() {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _bookInfo(),
            _item(title: 'Number of publications',
                controller: state.countController,
                keyboardType: TextInputType.number,
                inputFormatter: FilteringTextInputFormatter.digitsOnly,
                legal: state.countLegal.value),
            _inkItem(title: 'Public chain', value: state.publicChain),
            _inkItem(title: 'Currency', value: state.coinType),
            _item(title: 'Unit price', controller: state.univalentController, keyboardType: TextInputType.number),
            _item(title: 'Royalties', controller: state.royaltiesController, keyboardType: TextInputType.number, legal: state.royaltiesLegal.value),
            _inkItem(title: 'Pre-sale time', value: state.publishTime),
            _item(title: 'Supply cycle/minute',
                controller: state.periodController,
                keyboardType: TextInputType.number,
                inputFormatter: FilteringTextInputFormatter.digitsOnly,
                legal: state.periodLegal.value),
            _item(title: 'Limit',
                controller: state.limitController,
                keyboardType: TextInputType.number,
                inputFormatter: FilteringTextInputFormatter.digitsOnly,
                legal: state.limitLegal.value),
            SizedBox(height: 20.h),
            _hint(),
            _commitButton(),
            SizedBox(height: 20.h),
          ]);
        }),
      );

  Widget _bookInfo() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Image.network(state.bookInfo?.coverUrl ?? '', width: 1.sw - ScreenConfig.marginH * 2, height: (1.sw - ScreenConfig.marginH * 2) * 1.288, fit: BoxFit.cover),
        SizedBox(height: 30.h),
        TextX(state.bookInfo?.title, fontSize: FontSizeX.s16, color: ColorX.txtTitle, textAlign: TextAlign.start),
        SizedBox(height: 30.h),
        TextX(state.bookInfo?.desc, fontSize: FontSizeX.s11, color: ColorX.txtHint, textAlign: TextAlign.start),
      ]);

  Widget _inkItem({required String title, required var value}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tag(title),
          InkWell(
              onTap: () => _onClick(title),
              child: Container(
                width: 1.sw,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 14.h),
                decoration: BoxDecoration(border: Border.all(width: 1.r, color: ColorX.txtTitle)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() =>
                        TextX(!(value.value is String) ? DateUtil.formatDate(value.value, format: DateFormats.y_mo_d_h_m) : value.value.toString(),
                            fontSize: FontSizeX.s11, color: ColorX.txtTitle)),
                    Icon(Icons.chevron_right)
                  ],
                ),
              )),
        ],
      );

  Widget _item({required String title, required TextEditingController controller, String? hint, int? maxLines, TextInputType? keyboardType, TextInputFormatter? inputFormatter, bool legal = true}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tag(title),
          TextField(
            maxLines: maxLines ?? 1,
            maxLength: 300,
            textAlignVertical: TextAlignVertical.bottom,
            textAlign: TextAlign.start,
            keyboardType: keyboardType,
            inputFormatters: [inputFormatter ?? FilteringTextInputFormatter.allow(RegExp("[0-9.]"))],
            style: TextStyle(fontSize: FontSizeX.s11, color: ColorX.txtTitle),
            controller: controller,
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 24.h),
              fillColor: Colors.white,
              filled: true,
              hintText: hint,
              hintStyle: TextStyle(color: Color(0xFF999999), fontSize: FontSizeX.s11),
              counterText: '',
              enabledBorder: OutlineInputBorder(
                /*边角*/
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: legal ? ColorX.txtTitle : ColorX.txtRed,
                  width: 1.r,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                /*边角*/
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: legal ? ColorX.txtTitle : ColorX.txtRed,
                  width: 1.r,
                ),
              ),
              border: OutlineInputBorder(
                /*边角*/
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: legal ? ColorX.txtTitle : ColorX.txtRed,
                  width: 1.r,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: legal ? ColorX.txtTitle : ColorX.txtRed,
                  width: 1.r,
                ),
                borderRadius: BorderRadius.zero,
              ),
            ),
          )
        ],
      );

  Widget _tag(String title, {double? marginTop}) =>
      Container(
        child: TextX(title, color: ColorX.txtTitle, fontSize: FontSizeX.s13),
        margin: EdgeInsets.only(top: marginTop ?? 30.h, bottom: 15.h),
      );

  Widget _hint() =>
      TextX(
        'Books not purchased after the end of supply will be sold in full \nThere is no minting fee for the listing process, which will be automatically deducted'
            ' when the first transaction is completed',
        color: ColorX.txtHint,
        fontSize: FontSizeX.s11,
        maxLines: 100,
        textAlign: TextAlign.start,
      );

  Widget _commitButton() =>
      Obx(() {
        return ButtonX(
          'Data encryption',
          margin: EdgeInsets.only(top: 60.h),
          backgroundColor: state.buttonValid.value ? Color(0xFF42392B) : ColorX.buttonInValid,
          borderRadius: 0,
          textColor: state.buttonValid.value ? ColorX.txtYellow : ColorX.txtHint,
          fontSize: FontSizeX.s13,
          enable: state.buttonValid.value,
          padding: EdgeInsets.symmetric(vertical: 28.h),
          onPressed: () => _onClick('commit'),
        );
      });

  _onClick(type) {
    switch (type) {
      case 'commit':
        logic.publish();
        break;
      case 'Public chain':
        new Picker(
            adapter: PickerDataAdapter<String>(pickerData: state.publicChainList),
            changeToFirst: true,
            hideHeader: false,
            onConfirm: (Picker picker, List value) {
              logic.setChain(picker.adapter.text.replaceAll('[', '').replaceAll(']', ''));
            }).showModal(Get.context!);
        break;
      case 'Currency':
        new Picker(
            adapter: PickerDataAdapter<String>(pickerData: state.coinTypeList),
            changeToFirst: true,
            hideHeader: false,
            onConfirm: (Picker picker, List value) {
              logic.setCoin(picker.adapter.text.replaceAll('[', '').replaceAll(']', ''));
            }).showModal(Get.context!);
        break;
      case 'Pre-sale time':
      // DatePicker.showDatePicker(Get.context!, showTitleActions: true, minTime: DateTime.now(), maxTime: DateTime.now().add(Duration(days: 365)), onConfirm: (date) {
      //   logic.setTime(date);
      // }, currentTime: DateTime.now());

        var now = DateUtil.getDateTimeByMs(GlobalTimeService.to.globalTime.value);

        // DatePicker.showDateTimePicker(Get.context!,
        //     showTitleActions: true,
        //     minTime: DateTime(now.year, now.month, now.day, now.hour, now.minute),
        //     maxTime:  DateTime(now.year, now.month, now.day, now.hour, now.minute).add(Duration(days: 365)), onChanged: (date) {
        //       logic.setTime(date);
        //     }, onConfirm: (date) {
        //       print('confirm1 $date');
        //     }, locale: LocaleType.en);

        DatePicker.showDateTimePicker(Get.context!,
            showTitleActions: true,
            minTime: DateTime(now.year, now.month, now.day, now.hour, now.minute).add(Duration(minutes: 3)),
            maxTime: DateTime(now.year, now.month, now.day, now.hour, now.minute).add(Duration(days: 30)),
            onConfirm: (date) {
              logic.setTime(date);
            },
            locale: LocaleType.en);
        break;
    }
  }
}
