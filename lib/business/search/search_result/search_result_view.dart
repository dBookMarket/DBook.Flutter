import 'package:dbook/common/values/colors.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../common/widgets/text.dart';
import '../../../generated/assets.dart';
import 'search_result_logic.dart';

class SearchResultPage extends StatelessWidget {
  final logic = Get.put(SearchResultLogic());
  final state = Get.find<SearchResultLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Search results'),
      body: _body(),
    );
  }

  Widget _body() => Column(
        children: [SizedBox(height: 36.h), _search(), SizedBox(height: 30.h), _hint()],
      );

  Widget _search() => GestureDetector(
        // onTap: () => Get.to(() => SearchResultPage()),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40.w),
          padding: EdgeInsets.all(34.r),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), border: Border.all(width: 1.r, color: Colors.black)),
          child: Row(
            children: [
              SvgPicture.asset(Assets.svgHomeSearch, width: 32.r, height: 32.r, color: Color(0xFF686868)),
              SizedBox(width: 40.w),
              Expanded(
                  child: InputWidget(
                hint: 'Search for author, book title...',
                style: TextStyle(color: ColorX.txtTitle, fontSize: FontSizeX.s13),
                hintStyle: TextStyle(color: ColorX.txtHint, fontSize: FontSizeX.s13),
              )),
            ],
          ),
        ),
      );

  Widget _hint() => Container(
        child: TextX(
          '''The search does not guarantee the authenticity of the author's identity, please check the author's Twitter identity before purchasing the collection''',
          maxLines: 10,
          textAlign: TextAlign.start,
          fontSize: FontSizeX.s11,
          color: ColorX.txtRed,
        ),
        padding: EdgeInsets.symmetric(horizontal: 40.w),
      );
}
