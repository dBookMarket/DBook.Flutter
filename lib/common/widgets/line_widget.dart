import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../values/colors.dart';

// ignore: must_be_immutable
class LineH extends StatelessWidget {
  double height;
  double? width;
  Color? color;
  EdgeInsets margin;
  double? opacity;

  LineH(
      {Key? key,
      this.width,
      this.height = 1,
      this.color,
      this.margin = EdgeInsets.zero,
      this.opacity});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: this.opacity ?? 1,
      child: Container(
        height: this.height.h,
        margin: this.margin,
        color: this.color??ColorX.divider,
        width: this.width ?? ScreenUtil().screenWidth,
      ),
    );
  }
}

// ignore: must_be_immutable
class LineV extends StatelessWidget {
  double? height;
  double? width;
  Color? color;
  EdgeInsets margin;
  double? opacity;

  LineV(
      {Key? key,
        this.width = 1,
        this.height,
        this.color ,
        this.margin = EdgeInsets.zero,
        this.opacity
      });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: this.opacity ?? 1,
      child: Container(
        height: this.height ?? 10.h,
        margin: this.margin,
        color: this.color??ColorX.divider,
        width: this.width != null ? this.width!.w:ScreenUtil().screenWidth,
      ),
    );
  }
}

// ignore: must_be_immutable
class Dotted extends StatelessWidget {
  double height;
  double? width;
  Color? color;
  EdgeInsets margin;
  double? opacity;

  Dotted(
      {Key? key,
        this.width,
        this.height = 1,
        this.color,
        this.margin = EdgeInsets.zero,
        this.opacity = 1});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: this.opacity ?? 1,
      child: Container(
        height: this.height.h,
        margin: this.margin,
        width: this.width ?? ScreenUtil().screenWidth,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final boxWidth = constraints.constrainWidth();
            final dashWidth = 8.0;
            final dashHeight = height;
            final dashCount = (boxWidth / (1.5 * dashWidth)).floor();
            return Flex(
              children: List.generate(dashCount, (_) {
                return SizedBox(
                  width: dashWidth,
                  height: dashHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: this.color??ColorX.divider),
                  ),
                );
              }),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
            );
          },
        ),
      ),
    );
  }
}
