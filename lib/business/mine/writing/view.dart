import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:get/get.dart';

import 'logic.dart';

class WritingPage extends StatelessWidget {
  final logic = Get.put(WritingLogic());
  final state = Get.find<WritingLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Writing'),
      body: BaseContainer(viewState: state.viewState, child: _body()),
    );
  }

  Widget _body()=>Column(
    children: [
      QuillToolbar.basic(controller: state.quillController),
      Expanded(
        child: Container(
          child: QuillEditor.basic(
            controller: state.quillController,
            embedBuilders: FlutterQuillEmbeds.builders(),
            readOnly: false, // true for view only mode
          ),
        ),
      )
    ],
  );
}
