import 'package:flutter/material.dart';
import '../utils/keyboard.dart';
import '../values/colors.dart';

class BaseContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? background;

  BaseContainer({Key? key,  required this.child,this.margin, this.padding, this.background})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        KeyboardX.keyboardBack();
      },
      child: Container(
        child:_childContainer()
      ),
    );
  }

  Widget _childContainer() => Container(
        color: background ?? ColorX.primaryBackground,
        margin: margin,
        padding: padding,
        child: child,
      );




}
