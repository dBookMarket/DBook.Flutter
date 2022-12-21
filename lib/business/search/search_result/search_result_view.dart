import 'package:dbook/business/assets/assets_state.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:dbook/common/values/colors.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/input.dart';
import 'package:dbook/common/widgets/line_widget.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/entities/issues_entity.dart';
import '../../../common/widgets/text.dart';
import '../../../generated/assets.dart';
import '../../issues/issues_detail/issues_detail_view.dart';
import 'search_result_logic.dart';

class SearchResultPage extends StatelessWidget {
  final logic = Get.put(SearchResultLogic());
  final state = Get.find<SearchResultLogic>().refreshState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Search results'),
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
              viewState: state.viewState,
            ))
          ],
        ),
      );

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
              onChanged: (t) => logic.search(t),
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
              return _item(state.list[index]);
            }),
      );
    });
  }

  Widget _item(IssuesEntity info) => GestureDetector(
    onTap: ()=>Get.to(()=>IssuesDetailPage(),arguments: {'detail':info}),
    child: Container(
      color: Colors.transparent,
      child: Column(
      children: [
        Container(
          width: 1.sw,
          height: 180.h,
          margin: EdgeInsets.symmetric(horizontal: 40.w),
          child: Row(
            children: [
              Image.network(
                info.book?.coverUrl ?? '',
                height: 180.h,
                width: 140.w,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 23.w),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.network(info.book?.author?.avatarUrl ?? '', width: 30.r, height: 30.r),
                          SizedBox(width: 12.w),
                          TextX(info.book?.author?.name, fontSize: FontSizeX.s11, color: ColorX.txtHint),
                          Expanded(child: SizedBox()),
                          _comingDay(info.status,info.publishedAt)
                        ],
                      ),
                      SizedBox(height: 14.h),
                      TextX(
                        info.book?.title,
                        fontSize: FontSizeX.s15,
                        color: ColorX.txtTitle,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                      ),
                      Expanded(child: SizedBox()),
                      Row(
                        children: [
                          _issueStatus(info),
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
        LineH(margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 50.h))
      ],
    ),),);

  Widget _comingDay(status,time) {
    if(status == IssuesStatus.pre_sale.name){
      return Row(children: [
        SvgPicture.asset(Assets.svgComingTime, width: 20.w, color: ColorX.txtBrown),
        SizedBox(width: 11.w),
        TextX(time, fontSize: FontSizeX.s11, color: ColorX.txtBrown),
      ]);
    }else{
      return SizedBox();
    }
  }

  Widget _issueStatus(IssuesEntity info) {
    logX.d('书籍状态>>>>>${info.book?.status}');
    if (info.status == IssuesStatus.on_sale.name) {
      return Row(
        children: [
          _itemPrice('Floor price', '${info.price ?? 0}USDC'),
          _itemPrice('Circulation', '${info.nCirculations ?? 0}'),
          _itemPrice('Destruction', '${(info.quantity ?? 0)-(info.nCirculations ?? 0)}'),
        ],
      );
    } else if (info.status == IssuesStatus.pre_sale.name) {
      return Row(
        children: [
          _itemPrice('Lssue price', '${info.price ?? 0}USDC'),
          _itemPrice('Available', '${info.quantity ?? 0}'),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget _itemPrice(String title, String value) => Container(
        margin: EdgeInsets.only(right: 44.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextX(title, fontSize: FontSizeX.s11, color: ColorX.txtHint),
            SizedBox(height: 4.h),
            TextX(value.toString(), fontSize: FontSizeX.s11, color: ColorX.txtTitle),
          ],
        ),
      );
}
