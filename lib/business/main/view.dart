import 'package:dbook/business/login/guide/view.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/store/user.dart';
import '../../common/values/colors.dart';
import '../../common/widgets/view_state/base_container_view.dart';
import 'logic.dart';

class MainPage extends StatelessWidget {
  final logic = Get.put(MainLogic());
  final state = Get.find<MainLogic>().state;

  // late PageController pageController =
  //     PageController(initialPage: this.state.selectIndex, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
        viewState: state.viewState,
        child: Scaffold(
          bottomNavigationBar: _bottomBar(),
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: state.pageController,
            children: state.pages,
            onPageChanged: (index) => this.state.selectIndex = index,
          ),
        ));
  }

  BottomAppBar _bottomBar() {
    List<Widget> items = state.pages.asMap().keys.map((index) => Obx(() => _bottomBarItem(index))).toList();
    return BottomAppBar(
      color: ColorX.primaryYellow,
      // elevation: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _bottomBarItem(int index) {
    bool isSelect = this.state.selectIndex == index;
    return GestureDetector(
      onTap: () {
        if (!isSelect) {
          if(index == 1 && !UserStore.to.isLogin){
            Get.to(()=>GuidePage());
            return;
          }
          state.pageController.jumpToPage(index);
        }
      },
      child: Container(
        width: 1.sw / state.icons.length,
        color: Colors.transparent,
        padding: EdgeInsets.only(top: 24.h, bottom: 20.h),
        child: isSelect
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextX(state.tabTitles[index],fontSize: 32.sp,color: ColorX.bottomBarColor,fontWeight: FontWeight.bold),
                  SizedBox(height: 8.h),
                  Container(
                    width: 10.r,
                    height: 10.r,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: ColorX.bottomBarColor),
                  )
                ],
              )
            : SvgPicture.asset(state.icons[index],color: ColorX.bottomBarColor,height: 39.h),
      ),
    );
  }
}
