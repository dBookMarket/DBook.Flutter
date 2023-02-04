import 'package:dbook/common/config/app_config.dart';
import 'package:dbook/common/values/fontSize.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import 'logic.dart';

class WritingPage extends StatelessWidget {
  final logic = Get.put(WritingLogic());
  final state = Get.find<WritingLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Writing', actions: [_save()]),
      body: BaseContainer(viewState: state.viewState, child: _body()),
    );
  }

  Widget _save() => Container(
        child: InkWell(child: TextX('save',fontSize: FontSizeX.s13,), onTap: () => logic.save()),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: ScreenConfig.marginH),
      );

  Widget _body() => Column(
        children: [
          QuillToolbar.basic(controller: state.quillController),
          Expanded(
            child: Container(
              child: QuillEditor(
                controller: state.quillController,
                readOnly: false, // true for view only mode
                scrollController: ScrollController(),
                scrollable: true,
                focusNode: FocusNode(),
                autoFocus: true,
                expands: true,
                padding: EdgeInsets.zero,
                keyboardAppearance: Brightness.light,
              ),
            ),
          )
        ],
      );
}
