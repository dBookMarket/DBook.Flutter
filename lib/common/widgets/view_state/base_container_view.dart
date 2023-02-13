import 'package:dbook/common/widgets/view_state/state_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/assets.dart';
import '../../config/app_config.dart';
import '../../utils/keyboard.dart';
import '../../values/colors.dart';
import '../text.dart';

class BaseContainer extends StatelessWidget {
  final Widget? shimmer;
  final Rx<ViewState> viewState;
  final Widget child;
  final Widget? emptyView;
  final Widget? noNetView;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? background;
  final VoidCallback? retry;

  BaseContainer(
      {Key? key,
      required this.viewState,
      required this.child,
      this.shimmer,
      this.emptyView,
      this.noNetView,
      this.margin,
      this.padding,
      this.retry,
      this.background})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        KeyboardX.keyboardBack();
      },
      child: Container(
        child: Obx(() {
          return handleWidget();
        }),
      ),
    );
  }

  Widget _childContainer() => Container(
        color: background ?? ColorX.primaryBackground,
        margin: margin,
        padding: padding,
        child: child,
      );

  Widget handleWidget() {
    debugPrint('page state >>>>${viewState.value}');
    switch (this.viewState.value) {
      case ViewState.IDLE:
        return _childContainer();
      case ViewState.BUSY:
        return this.shimmer ?? DefaultShimmerWidget();
      case ViewState.EMPTY:
        return this.emptyView ?? DefaultEmptyWidget(retry: retry);
      case ViewState.SUCCESS:
        return _childContainer();
      case ViewState.ERROR:
        return DefaultErrorWidget(retry: retry);
      case ViewState.NO_NET:
        return this.noNetView ?? DefaultErrorWidget(retry: retry);
    }
  }
}

class DefaultEmptyWidget extends StatelessWidget {
  final VoidCallback? retry;

  const DefaultEmptyWidget({Key? key, this.retry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.svgIssuesDetailNoData, width: 50.w),
        SizedBox(height: 20.h),
        TextX('no data', color: ColorX.txtHint),
      ],
    );
  }
}

class DefaultNoNetWidget extends StatelessWidget {
  final VoidCallback? retry;

  const DefaultNoNetWidget({Key? key, this.retry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultExceptionBox(desc: '暂无内容', img: Assets.iconsNoNet, retry: retry);
  }
}

class DefaultErrorWidget extends StatelessWidget {
  final VoidCallback? retry;

  const DefaultErrorWidget({Key? key, this.retry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultExceptionBox(desc: '暂无内容', img: Assets.iconsNoData, retry: retry);
  }
}

class DefaultShimmerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Lottie.asset(Assets.assetsLoading),
        SizedBox(
          height: ScreenConfig.appBarHeight + 80,
        )
      ],
    );
  }
}

class DefaultExceptionBox extends StatelessWidget {
  final String img;
  final String desc;
  final VoidCallback? retry;

  DefaultExceptionBox({required this.img, required this.desc, this.retry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(img),
        retry == null
            ? TextX('$desc,请稍后重试', fontSize: 42.sp, color: ColorX.txtDesc)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextX('$desc,请', fontSize: 42.sp, color: ColorX.txtDesc),
                  GestureDetector(
                    onTap: retry,
                    child: Row(
                      children: [TextX('重试', fontSize: 42.sp, color: ColorX.primaryMain), Image.asset(Assets.iconsRetry)],
                    ),
                  )
                ],
              ),
        SizedBox(
          height: ScreenConfig.appBarHeight + 80,
        )
      ],
    );
  }
}
