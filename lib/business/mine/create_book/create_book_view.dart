import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/button.dart';
import 'package:dbook/common/widgets/line_widget.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../common/config/app_config.dart';
import '../../assets/assets_state.dart';
import '../../assets/assets_view.dart';
import 'create_book_logic.dart';

class CreateBookPage extends StatelessWidget {
  final logic = Get.put(CreateBookLogic());
  final state = Get.find<CreateBookLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Create a book'),
      body: BaseContainer(viewState: state.viewState, child: _body()),
    );
  }

  Widget _body() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tab(),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => state.tabIndex == 0 ? _fileSelect() : _draft()),
                    _coverSelect(),
                    _bookTitle(),
                    _bookDesc(),
                    _encryptionButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget _fileSelect() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _tag('Book', marginTop: 0),
        Row(
          children: [
            _fileSelectBox('PDF、EPUB、TXT'),
            SizedBox(width: 20.w),
            Expanded(
              child: Container(
                height: 300.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return TextX(
                        state.asset.value == null ? 'Data processing cannot be  modified' : state.asset.value?.path,
                        fontSize: FontSizeX.s11,
                        color: ColorX.txtRed,
                        maxLines: 10,
                        textAlign: TextAlign.start,
                      );
                    }),
                    TextX('Supported file formats PDF、EPUB、TXT，File < 200M', fontSize: FontSizeX.s11, color: ColorX.txtHint, maxLines: 10, textAlign: TextAlign.start),
                  ],
                ),
              ),
            )
          ],
        )
      ]);

  Widget _draft() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_tag('Drafts', marginTop: 0), SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: state.drafts.asMap().keys.map(_draftItem).toList()))]);

  Widget _draftItem(int index) => Container(
        margin: EdgeInsets.only(right: 20.w),
        child: InkWell(
          onTap: () => logic.selectDraft(index),
          child: Stack(
            children: [
              Container(
                  width: 230.w,
                  height: 300.w,
                  alignment: Alignment.bottomCenter,
                  color: Color(0xFFEAC38A),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(Assets.svgBookDraft, width: 55.w),
                      SizedBox(height: 20.h),
                      TextX(state.drafts[index].title, fontSize: FontSizeX.s11, color: ColorX.txtBrown),
                      SizedBox(height: 48.h)
                    ],
                  )),
              _draftSelector(index)
            ],
          ),
        ),
      );

  Widget _draftSelector(int index) => Positioned(
      right: 20.r,
      top: 20.r,
      child: Obx(() {
        return SvgPicture.asset(state.selectedDraftId.value == state.drafts[index].id ? Assets.svgDraftSelected : Assets.svgDraftUnselect, width: 40.w);
      }));

  Widget _coverSelect() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _tag('Cover'),
        Row(
          children: [
            Obx(() {
              return _fileSelectBox('JPG、PNG', image: state.cover.value);
            }),
            SizedBox(width: 20.w),
            Expanded(
              child: Container(
                alignment: Alignment.bottomLeft,
                height: 300.w,
                child: TextX('Supported file formats JPG、PNG，\nFile < 5M', fontSize: FontSizeX.s11, color: ColorX.txtHint, maxLines: 10, textAlign: TextAlign.start),
              ),
            )
          ],
        )
      ]);

  Widget _bookTitle() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tag('Book title'),
          TextField(
            maxLines: 1,
            maxLength: 20,
            textAlignVertical: TextAlignVertical.bottom,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: FontSizeX.s11, color: ColorX.txtTitle),
            controller: state.titleController,
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 30.h),
              fillColor: Color(0xFFF6F6F6),
              filled: true,
              hintStyle: TextStyle(color: Color(0xFF999999), fontSize: FontSizeX.s11),
              counterText: '',
              enabledBorder: OutlineInputBorder(
                /*边角*/
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: ColorX.txtTitle,
                  width: 1.r,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                /*边角*/
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: ColorX.txtTitle,
                  width: 1.r,
                ),
              ),
              border: OutlineInputBorder(
                /*边角*/
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: ColorX.txtTitle,
                  width: 1.r,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorX.txtTitle,
                  width: 1.r,
                ),
                borderRadius: BorderRadius.zero,
              ),
            ),
          )
        ],
      );

  Widget _bookDesc() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tag('Description'),
          TextField(
            maxLines: 4,
            maxLength: 300,
            textAlignVertical: TextAlignVertical.bottom,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: FontSizeX.s11, color: ColorX.txtTitle),
            controller: state.descController,
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: EdgeInsets.all(20.r),
              fillColor: Color(0xFFF6F6F6),
              filled: true,
              hintText: 'Write a description of your drawing, such as a part, how it  differs from the standard version,or some signatures worth collecting',
              hintStyle: TextStyle(color: Color(0xFF999999), fontSize: FontSizeX.s11),
              counterText: '',
              enabledBorder: OutlineInputBorder(
                /*边角*/
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: ColorX.txtTitle,
                  width: 1.r,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                /*边角*/
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: ColorX.txtTitle,
                  width: 1.r,
                ),
              ),
              border: OutlineInputBorder(
                /*边角*/
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: ColorX.txtTitle,
                  width: 1.r,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorX.txtTitle,
                  width: 1.r,
                ),
                borderRadius: BorderRadius.zero,
              ),
            ),
          )
        ],
      );

  Widget _encryptionButton() => Obx(() {
        return ButtonX(
          'Data encryption',
          margin: EdgeInsets.only(top: 60.h),
          backgroundColor: state.buttonValid.value ? Color(0xFF42392B) : ColorX.buttonInValid,
          borderRadius: 0,
          textColor: state.buttonValid.value ? ColorX.txtYellow : ColorX.txtHint,
          fontSize: FontSizeX.s13,
          enable: state.buttonValid.value,
          padding: EdgeInsets.symmetric(vertical: 28.h),
          onPressed: () => _click('encryption'),
        );
      });

  Widget _tab() => Container(
      child: Obx(() {
        return Row(
          children: state.tabs.asMap().keys.map(_tabItem).toList(),
        );
      }),
      color: ColorX.primaryYellow);

  Widget _tabItem(int index) => Expanded(
        child: GestureDetector(
          onTap: () => _click('switch_tab', param: index),
          child: Column(children: [
            SizedBox(height: 28.h),
            TextX(state.tabs[index], fontSize: FontSizeX.s13, color: ColorX.txtTitle, fontWeight: state.tabIndex == index ? TextX.bold : FontWeight.normal),
            SizedBox(height: 28.h),
            LineH(color: state.tabIndex == index ? ColorX.txtTitle : Colors.transparent, width: 162.w, height: 2.h),
          ]),
        ),
      );

  Widget _tag(String title, {double? marginTop}) => Container(
        child: TextX(title, color: ColorX.txtTitle, fontSize: FontSizeX.s13),
        margin: EdgeInsets.only(top: marginTop ?? 60.h, bottom: 30.h),
      );

  Widget _fileSelectBox(String name, {dynamic image}) => GestureDetector(
        onTap: () => _click(name),
        child: Container(
          width: 230.w,
          height: 300.w,
          decoration: BoxDecoration(border: Border.all(width: 1.r, color: ColorX.txtTitle)),
          child: image != null
              ? Image.file(image, fit: BoxFit.cover)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SvgPicture.asset(Assets.svgBookCover, width: 64.w), SizedBox(height: 20.h), TextX(name, fontSize: FontSizeX.s11, color: ColorX.txtHint)],
                ),
        ),
      );

  Widget _headerForDialog({required VoidCallback callback}) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
          padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: ScreenConfig.marginH),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextX('Data encryption', fontSize: FontSizeX.s13, color: ColorX.txtTitle),
              SizedBox(height: 30.h),
              TextX(
                'Data encryption and upload IPFS is expected to take several minutes ~ hours depending on the file size and format, and the processing progress can be viewed in the '
                'publication;management,and subsequent publishing settings can be carried out after: the processing is completed',
                fontSize: FontSizeX.s13,
                color: ColorX.txtHint,
                textAlign: TextAlign.left,
                maxLines: 100,
              ),
              SizedBox(height: 30.h),
              ButtonX(
                'head for',
                onPressed: callback,
                padding: EdgeInsets.symmetric(vertical: 24.h),
                backgroundColor: ColorX.primaryBrown,
                textColor: ColorX.txtWhite,
                fontSize: FontSizeX.s13,
                borderRadius: 10.r,
              )
            ],
          ),
        ),
      );

  _click(action, {param}) async {
    switch (action) {
      case 'switch_tab':
        logic.switchTab(param);
        break;
      case 'encryption':
        await logic.uploadBook();
        Get.dialog(
            _headerForDialog(
              callback: () => {
                Get.until((route) => route.isFirst),
                Get.to(() => AssetsPage(), arguments: {'title': 'My Assets', 'assetsType': AssetsType.MY_ASSETS, 'tabIndex': 1}, preventDuplicates: false),
              },
            ),
            arguments: {'detail': null});
        break;
      case 'PDF、EPUB、TXT':
        logic.selectAsset();
        break;
      case 'JPG、PNG':
        logic.selectCover();
        break;
    }
  }
}
