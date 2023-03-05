import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/input.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../common/widgets/text.dart';
import '../../../generated/assets.dart';
import '../../issues/issue_item/issue_item.dart';
import 'search_result_logic.dart';

class SearchResultPage extends StatelessWidget {
  final logic = Get.put(SearchResultLogic());
  final state = Get.find<SearchResultLogic>().refreshState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Search results'),
      resizeToAvoidBottomInset: false,
      body: _body(),
    );
  }

  Widget _body() => Container(
        width: 1.sw,
        height: 1.sh,
        child: Column(
          children: [
            SizedBox(height: 36.h),
            _search(),
            SizedBox(height: 30.h),
            _hint(),
            Expanded(
                child: BaseContainer(
              child: _list(),
              retry: logic.refresh,
              viewState: state.viewState,
              emptyView: _stateBox(DefaultEmptyWidget()),
              shimmer: _stateBox(DefaultShimmerWidget()),
              errorView: _stateBox(DefaultErrorWidget(retry: logic.refresh)),
              noNetView: _stateBox(DefaultNoNetWidget(retry: logic.refresh)),
            ))
          ],
        ),
      );

  Widget _stateBox(Widget widget) => Container(child:widget,margin: EdgeInsets.only(bottom: 180));

  Widget _search() => Container(
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
              autofocus: true,
              textInputAction: TextInputAction.search,
              onSubmitted: (t) => logic.search(t),
            )),
          ],
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

  Widget _list() {
    return Obx(() {
      return SmartRefresher(
        controller: state.refreshController,
        onRefresh: logic.refresh,
        onLoading: logic.loadMore,
        enablePullUp: state.canLoadMore,
        enablePullDown: false,
        child: ListView.builder(
            itemCount: state.list.length,
            padding: EdgeInsets.only(top: 50.h),
            itemBuilder: (ctx, index) {
              return IssuesItemView(state.list[index]);
            }),
      );
    });
  }
}
