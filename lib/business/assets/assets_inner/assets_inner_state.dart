import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AssetsInnerState {

  late List<String> filter;
  late int innerType = 3;
  final PageController pageController = PageController();
  late TabController tabController;
  List<Widget> pages = [];
  late String issueId;
  AssetsInnerState() {
    innerType = Get.arguments?['type']??5;
    if(innerType == 3){
      filter = ['List','Activity','Trend'];
      pages.add(Container(color: Colors.red,width: 1.sw,height: 200,));
      pages.add(Container(color: Colors.black,width: 1.sw,height: 200,));
      pages.add(Container(color: Colors.blue,width: 1.sw,height: 200,));
    }else if(innerType == 4){
      filter = ['List','Activity','Trend','Trend'];
      pages.add(Container(color: Colors.black,width: 1.sw,height: 200,));
      pages.add(Container(color: Colors.blue,width: 1.sw,height: 200,));
      pages.add(Container(color: Colors.red,width: 1.sw,height: 200,));
      pages.add(Container(color: Colors.black,width: 1.sw,height: 200,));
    }else {
      filter = ['List','Activity','Trend','Trend','List'];
      pages.add(Container(color: Colors.red,width: 1.sw,height: 200,));
      pages.add(Container(color: Colors.black,width: 1.sw,height: 200,));
      pages.add(Container(color: Colors.blue,width: 1.sw,height: 200,));
      pages.add(Container(color: Colors.red,width: 1.sw,height: 200,));
      pages.add(Container(color: Colors.black,width: 1.sw,height: 200,));
    }
  }
}
