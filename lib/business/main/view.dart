import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/widgets/base_container_view.dart';
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
          floatingActionButton: _centerButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: state.pageController,
            children: state.pages,
            onPageChanged: (index) => this.state.selectIndex = index,
          ),
        ));
  }

  BottomAppBar _bottomBar() {
    List<Widget> items = state.pages
        .asMap()
        .keys
        .map((index) => Obx(() => _bottomBarItem(index)))
        .toList();
    return BottomAppBar(
      color: ColorX.bottomBarBgColor,
      // elevation: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _bottomBarItem(int index) {
    bool isSelect = this.state.selectIndex == index;
    if(index == 2) return SizedBox(width: 1.sw/state.icons.length);
    return GestureDetector(
      onTap: () {
        if (!isSelect) {
          state.pageController.jumpToPage(index);
        }
      },
      child: Container(
        width: 1.sw/state.icons.length,
        color: Colors.transparent,
        padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/icons/${state.icons[index]}_${isSelect ? 'selected' : 'unselect'}.png',
            ),
            Text(
              state.tabTitles[index],
              style: TextStyle(
                  color: isSelect
                      ? ColorX.bottomBarSelectedColor
                      : ColorX.bottomBarUnSelectedColor,
                  fontSize: 36.sp),
            )
          ],
        ),
      ),
    );
  }

  Widget _centerButton() => Container(
        margin: EdgeInsets.only(top: 40.h),
        decoration: BoxDecoration(boxShadow:[
          BoxShadow(color: ColorX.primaryYellow.withOpacity(0.2),spreadRadius: 1.r,blurRadius: 34.r,offset: Offset(0,2.r))
        ] ),
        child: FloatingActionButton(
          backgroundColor: ColorX.primaryYellow,
          foregroundColor: Colors.red,
          elevation: 0,
          onPressed: () =>Get.to(()=>MemberCodePage()),
          child: Image.asset(Assets.iconsIcTabCode, width: 72.w, height: 72.w),
        ),
      );
}
