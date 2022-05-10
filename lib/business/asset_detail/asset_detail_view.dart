import 'package:carousel_slider/carousel_slider.dart';
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
            bottom: 0,
          ),
        ],
      ),
    );
  }

  Widget _index() => Container(
        width: 1.sw,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Obx(() {
          return TextX(state.currentIndex.value.toString());
        }),
      );

  pages() {
    return CarouselSlider(
        items: state.images.map(_item).toList(),
        options: CarouselOptions(
          height: 1.sh,
          enableInfiniteScroll: false,
          enlargeCenterPage: false,
          disableCenter: false,
          viewportFraction: 1,
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 2),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          onPageChanged: (index, _) => state.currentIndex.value = index + 1,
          scrollDirection: Axis.horizontal,
          // pageViewKey: PageStorageKey<String>(HOME_BANNER_INDEX),
        ));
  }

  Widget _item(String image) => SingleChildScrollView(
        child: ImageHelper.network(image, width: 1.sw, fit: BoxFit.fitWidth),
      );
}
