import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:dbook/common/values/colors.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/utils/image_helper.dart';
import 'asset_detail_logic.dart';

class AssetDetailPage extends StatelessWidget {
  final logic = Get.put(AssetDetailLogic());
  final state = Get.find<AssetDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages(),
          Positioned(
            child: _index(),
            bottom: 10.h,
            left: 10.w,
          ),
        ],
      ),
    );
  }

  Widget _index() {
    return Obx(() {
      if (state.localFile.length == 0) return SizedBox();
      return Container(
        // width: 1.sw,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.1), borderRadius: BorderRadius.circular(100)),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        child: Center(
          child: Obx(() {
            return TextX(
              '${state.currentIndex.value + 1}/${state.localFile.length}',
              color: ColorX.primaryMain,
            );
          }),
        ),
      );
    });
  }

  pages() {
    return Obx(() {
      if (state.localFile.length == 0) return SizedBox();
      return CarouselSlider(
          items: state.localFile.map(_item).toList(),
          options: CarouselOptions(
            height: 1.sh,
            initialPage: state.currentIndex.value,
            enableInfiniteScroll: false,
            enlargeCenterPage: false,
            disableCenter: false,
            viewportFraction: 1,
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 2),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            onPageChanged: logic.onPageChanged,
            scrollDirection: Axis.horizontal,
            // pageViewKey: PageStorageKey<String>(HOME_BANNER_INDEX),
          ));
    });
  }

  Widget _item(dynamic image) {
    if (image is String) {
      return Center(
        child: TextX(
          'Loading',
          color: Colors.blue,
        ),
      );
    }
    // logX.d(image) ;
    return SingleChildScrollView(
      // child: ImageHelper.network(image, width: 1.sw, fit: BoxFit.fitWidth),
      child: Image.file(
        image,
        width: 1.sw,
        fit: BoxFit.cover,
        errorBuilder: (c, o, e) => Container(
          width: 1.sw,
          height: 1.sh,
          alignment: Alignment.center,
          child: TextX('Something has wrong,back home and retry'),
        ),
      ),
    );
  }
}
