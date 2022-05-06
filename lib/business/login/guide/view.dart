import 'package:dbook/common/utils/image_helper.dart';
import 'package:dbook/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../import_memories/import_memories_view.dart';
import 'logic.dart';

class GuidePage extends StatelessWidget {
  final logic = Get.put(GuideLogic());
  final state = Get.find<GuideLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: 1.sw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
                image: DecorationImage(fit: BoxFit.cover, image: AssetImage(ImageHelper.wrapAssets('bg_guide')))),
            child: _contentDesc(),
          ),
        ),
        Container(
          height: 190.h,
          child: _importButton(),
        )
      ],
    );
  }

  Widget _contentDesc() {
    String txt = 'D-BOOK购买的书籍可直接在当前阅读器中进行解码阅读，\n因版权保护问题，所以暂不支持对外阅读，\n若有不便敬请谅解';
    return Column(
      children: [
        SizedBox(
          height: 115.h,
        ),
        Image.asset(
          ImageHelper.wrapAssets('logo'),
          width: 180.r,
          height: 180.r,
        ),
        SizedBox(
          height: 48.h,
        ),
        Text(
          'D-BOOK',
          style: TextStyle(color: Colors.white, fontSize: 70.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 33.h,
        ),
        Text(
          txt,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _importButton() {
    return GestureDetector(
      onTap: () {
        Get.to(()=>ImportMemoriesPage());
      },
      child: Container(
        margin: EdgeInsets.only(left: 45.w, right: 45.w, bottom: 36.h, top: 64.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), border: Border.all(width: 1.r, color: ColorX.primaryMain)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '导入助记词',
              style: TextStyle(color: ColorX.primaryMain, fontSize: 30.sp, height: 1.2),
            ),
            Icon(
              Icons.chevron_right_sharp,
              color: ColorX.primaryMain,
            )
          ],
        ),
      ),
    );
  }
}
