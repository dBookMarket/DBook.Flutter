import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../common/utils/date.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fontSize.dart';
import '../../../common/widgets/avatar_widget.dart';
import '../../../common/widgets/line_widget.dart';
import '../../../common/widgets/text.dart';
import '../../../generated/assets.dart';
import '../issues_detail/issues_detail_view.dart';
import '../issues_state.dart';

// ignore: must_be_immutable
class IssuesItemView extends StatelessWidget {
  late var itemInfo;
  Widget? action;

  IssuesItemView(this.itemInfo,{this.action});

  @override
  Widget build(BuildContext context) {
    return _item();
  }

  Widget _item() => GestureDetector(
        onTap: () => Get.to(() => IssuesDetailPage(), arguments: {'detail': itemInfo}),
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
                    Stack(
                      children: [
                        Container(
                            child: Image.network(
                              itemInfo.book?.coverUrl ?? '',
                              height: 180.h,
                              width: 140.w,
                              fit: BoxFit.cover,
                            ),
                            margin: EdgeInsets.only(left: 4.w)),
                        _issueTag(),
                      ],
                    ),
                    SizedBox(width: 23.w),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AvatarX(itemInfo.book?.author?.avatarUrl ?? '', size: 30.r),
                            SizedBox(width: 12.w),
                            TextX(itemInfo.book?.author?.name, fontSize: FontSizeX.s11, color: ColorX.txtHint),
                            Expanded(child: SizedBox()),
                            _comingDay(itemInfo.status, itemInfo.publishedAt, itemInfo.duration)
                          ],
                        ),
                        SizedBox(height: 14.h),
                        TextX(
                          itemInfo.book?.title,
                          fontSize: FontSizeX.s15,
                          color: ColorX.txtTitle,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                        ),
                        Expanded(child: SizedBox()),
                        Row(
                          children: [
                            _issueStatus(),
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              ),
              action?? SizedBox(),
              LineH(margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 50.h))
            ],
          ),
        ),
      );

  Widget _comingDay(status, time, duration) {
    var date;
    if (status == IssuesStatus.pre_sale.name) {
      date = bookPublicationTimeFormat(DateUtil.getDateTime(time));
    } else if (status == IssuesStatus.on_sale.name) {
      date = bookPublicationTimeFormat(DateUtil.getDateTime(time)?.add(Duration(minutes: duration ?? 0)));
    } else {
      return SizedBox();
    }
    return Row(children: [
      SvgPicture.asset(Assets.svgComingTime, width: 20.w, color: ColorX.txtBrown),
      SizedBox(width: 11.w),
      TextX(date, fontSize: FontSizeX.s11, color: ColorX.txtBrown),
    ]);
  }

  Widget _issueTag() {
    var tag;
    if (itemInfo.status == IssuesStatus.on_sale.name) {
      tag = 'On sale';
    } else if (itemInfo.status == IssuesStatus.pre_sale.name) {
      tag = 'Pre sale';
    } else if (itemInfo.status == IssuesStatus.unsold.name) {
      tag = 'Unsold';
    } else {
      return SizedBox();
    }
    return Container(
      width: 120.w,
      padding: EdgeInsets.only(left: 8.w, top: 4.h, right: 18.w, bottom: 14.h),
      margin: EdgeInsets.only(top: 9.h),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.imagesIssueTag),
          fit: BoxFit.fill,
        ),
      ),
      child: TextX(tag, fontSize: FontSizeX.s9, color: Colors.white),
    );
  }

  Widget _issueStatus() {
    if (itemInfo.status == IssuesStatus.off_sale.name) {
      var floorPrice;
      if (itemInfo.toJson().containsKey('price_range')) {
        floorPrice = itemInfo.priceRange?.minPrice ?? 0;
      }else{
        floorPrice = null;
      }
      return Row(
        children: [
          floorPrice == null?SizedBox():_itemPrice('Floor price', '${floorPrice}USDC'),
          _itemPrice('Circulation', '${itemInfo.nCirculations ?? 0}'),
          _itemPrice('Destruction', '${(itemInfo.quantity ?? 0) - (itemInfo.nCirculations ?? 0)}'),
        ],
      );
    } else {
      return Row(
        children: [
          _itemPrice('Issue price', '${itemInfo.price ?? 0}USDC'),
          _itemPrice('Available', '${itemInfo.quantity ?? 0}'),
        ],
      );
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
