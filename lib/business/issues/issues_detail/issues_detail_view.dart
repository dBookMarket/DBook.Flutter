import 'package:dbook/common/config/app_config.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:dbook/common/widgets/web_page/web_page_view.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'issues_detail_logic.dart';

class IssuesDetailPage extends StatelessWidget {
  final logic = Get.put(IssuesDetailLogic());
  final state = Get.find<IssuesDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Book details'),
      body: _body(),
    );
  }

  Widget _body() => BaseContainer(
      viewState: state.viewState,
      padding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            state.issuesInfo.book?.coverUrl ?? '',
            width: 1.sw,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30.h),
          TextX(state.issuesInfo.book?.title, textAlign: TextAlign.start, fontSize: FontSizeX.s16, color: ColorX.txtTitle, fontWeight: TextX.bold),
          SizedBox(height: 20.h),
          _contact(),
          SizedBox(height: 20.h),
          TextX(state.issuesInfo.book?.desc, textAlign: TextAlign.start, fontSize: FontSizeX.s11, color: ColorX.txtHint,maxLines: 100),
        ],
      ));

  Widget _contact() => Row(
        children: [
          _contactItem(img: Assets.svgLogoWeb, url: state.issuesInfo.book?.author?.websiteUrl),
          _contactItem(img: Assets.svgLogoDiscord, url: state.issuesInfo.book?.author?.discordUrl),
          _contactItem(img: Assets.svgLogoTwitter, url: state.issuesInfo.book?.author?.twitterUrl),
        ],
      );

  Widget _contactItem({required String img, String? url}) {
    return Container(
      margin: EdgeInsets.only(right: 22.w),
      color: Colors.white,
      child: GestureDetector(
          child: SvgPicture.asset(img, width: 40.w,colorBlendMode: BlendMode.clear,),
          onTap: () {
            if (url == null || url.isEmpty) {
              state.setError(t: 'No valid');
            }
            Get.to(() => WebPageView('', url ?? ''));
          }),
    );
  }
}
