import 'package:dbook/business/mine/wallet/wallet_activity/wallet_activity_view.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:dbook/common/values/colors.dart';
import 'package:dbook/common/values/fontSize.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverlayStore extends GetxController with GetSingleTickerProviderStateMixin {
  static OverlayStore get to => Get.find();

  bool show = false;
  late Offset offset;

  late AnimationController _ctrl;

  final double width = 200;
  final double height = 30;
  final double outWidth = 35;
  final double boxHeight = 110;

  final double radius = 60;
  OverlayEntry? entry;
  double showWidth = 0;

  bool out = false;

  @override
  void onInit() {
    super.onInit();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..addListener(_listenAnimate);

    WidgetsBinding.instance.addPostFrameCallback((callback) {
      var px = MediaQuery.of(Get.context!).size.width - 100;
      var py = MediaQuery.of(Get.context!).size.height * 0.05;
      offset = Offset(px, py);

      entry = OverlayEntry(
          builder: (context) => Stack(
                children: <Widget>[
                  Positioned(
                    left: offset.dx,
                    top: offset.dy,
                    child: _buildFloating(),
                  ),
                ],
              ));
    });
  }

  final double circleRadius = 80;
  final double menuSize = 36;

  Widget _buildFloating() {
    // Color wrapColor = Colors.blue.withOpacity(0.6);
    // bool left = offset.dx < 100;

    return Container(
      width: circleRadius * 2,
      height: circleRadius * 2,
      alignment: Alignment.center,
      child: _buildCenter(),
    );
  }

  Widget _buildCenter() => GestureDetector(
        onTap: _onTap,
        onPanEnd: _onPanEnd,
        onPanUpdate: _updatePosition,
        child: Opacity(
          opacity: 0.8,
          child: Container(
            width: menuSize*2,
            height: menuSize,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(color: ColorX.primaryYellow, borderRadius: BorderRadius.circular(menuSize / 2), boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(0, 5),
              )
            ]),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(color: ColorX.primaryBrown, borderRadius: BorderRadius.circular(menuSize / 2)),
              child: TextX('paying',color: ColorX.primaryYellow,fontSize: FontSizeX.s13,),
            ),
          ),
        ),
      );

  double endX = 0;

  void _onTap() {
    Get.to(() => WalletActivityPage(), arguments: {'needAppBar': true});
  }

  void _onPanEnd(details) {
    endX = offset.dx;
    _ctrl.reset();
    _ctrl.forward();
  }

  void _listenAnimate() {
    // var px = MediaQuery.of(Get.context!).size.width - (outWidth);
    // offset = Offset(px - (_ctrl.value), offset.dy);
    double px;
    // print(offset.dx);
    if (offset.dx > MediaQuery.of(Get.context!).size.width / 2 - circleRadius) {
      double begin = endX;
      double end = MediaQuery.of(Get.context!).size.width - menuSize / 2 - circleRadius;
      double t = _ctrl.value;
      px = begin + (end - begin) * t; // x = menuSize / 2 - circleRadius;
    } else {
      double begin = endX;
      double end = menuSize / 2 - circleRadius;
      double t = _ctrl.value;
      px = begin + (end - begin) * t; // x = menuSize / 2 - circleRadius;
    }

    offset = Offset(px, offset.dy);
    entry?.markNeedsBuild();
  }

  void _updatePosition(DragUpdateDetails details) {
    double y = details.globalPosition.dy - circleRadius;
    double x = details.globalPosition.dx - circleRadius;
    if (x < menuSize / 2 - circleRadius) {
      x = menuSize / 2 - circleRadius;
    }

    if (y < menuSize / 2 - circleRadius) {
      y = menuSize / 2 - circleRadius;
    }

    if (x > MediaQuery.of(Get.context!).size.width - menuSize / 2 - circleRadius) {
      x = MediaQuery.of(Get.context!).size.width - menuSize / 2 - circleRadius;
    }

    if (y > MediaQuery.of(Get.context!).size.height - menuSize / 2 - circleRadius) {
      y = MediaQuery.of(Get.context!).size.height - menuSize / 2 - circleRadius;
    }
    offset = Offset(x, y);
    entry?.markNeedsBuild();
  }

  void showFloating() {
    if (!show && entry != null) {
      logX.d('showFloating>>>>$show');
      show = true;
      Overlay.of(Get.context!).insert(entry!);
    }
  }

  void hideFloating() {
    if (show) {
      entry?.remove();
      show = false;
    }
  }
}
