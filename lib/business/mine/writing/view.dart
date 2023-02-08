import 'package:dbook/common/config/app_config.dart';
import 'package:dbook/common/values/fontSize.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../../common/widgets/dialog.dart';
import 'logic.dart';

class WritingPage extends StatelessWidget {
  final logic = Get.put(WritingLogic());
  final state = Get.find<WritingLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Writing', actions: [_save()]),
      body: BaseContainer(viewState: state.viewState, child: _editor2()),
    );
  }

  Widget _save() => Container(
        child: InkWell(
            child: TextX(
              'save',
              fontSize: FontSizeX.s13,
            ),
            onTap: () => _onClick()),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: ScreenConfig.marginH),
      );

  Widget _editor2() => HtmlEditor(
        controller: state.htmlController, //required
        htmlEditorOptions: HtmlEditorOptions(
          hint: "Your text here...",
          initialText: state.draft?.content,
        ),
        htmlToolbarOptions: HtmlToolbarOptions(
          toolbarPosition: ToolbarPosition.aboveEditor,
          toolbarType: ToolbarType.nativeExpandable,
        ),
        otherOptions: OtherOptions(
          height: 1.sh - ScreenConfig.appBarHeight - ScreenUtil().statusBarHeight,
        ),
      );

  Widget _title() => Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: ScreenConfig.marginH),
        child: TextField(
          maxLines: 1,
          maxLength: 150,
          textAlignVertical: TextAlignVertical.bottom,
          textAlign: TextAlign.start,
          controller: state.titleController,
          decoration: InputDecoration(
            isCollapsed: true,
            contentPadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
            fillColor: Colors.white,
            filled: true,
            hintText: 'please enter a title',
            hintStyle: TextStyle(color: Color(0xFF999999), fontSize: FontSizeX.s14),
            counterText: '',
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1.r), borderRadius: BorderRadius.zero),
            disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.r, color: Colors.black), borderRadius: BorderRadius.zero),
            border: OutlineInputBorder(borderSide: BorderSide(width: 1.r, color: Colors.black), borderRadius: BorderRadius.zero),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1.r), borderRadius: BorderRadius.zero),
          ),
        ),
      );

  _onClick() {
    Get.dialog(DialogX(
      title: 'please enter a title',
      contentWidget: _title(),
      left: 'cancel',
      right: 'OK',
      needPop: false,
      leftCallback: () => Get.back(),
      rightCallback: () {
        if (!logic.titleEnable()) {
          return;
        }
        Get.back();
        logic.checkSave();
      },
    ));
  }
}
