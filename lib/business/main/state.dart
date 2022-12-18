import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class MainState extends BaseState {
  late PageController pageController = PageController(initialPage: selectIndex, keepPage: true);
  List<Widget> pages = [];
  List<String> icons = [
    'ic_tab_home',
    'ic_tab_shop',
    'ic_tab_shop',
    'ic_tab_goods',
    'ic_tab_mine',
  ];

  List<String> tabTitles = [
    '首页',
    '商户',
    '',
    '限时购',
    '我的',
  ];

  MainState() {
    this.pages.add(KeepAliveWrapper(child: HomePage()));
    this.pages.add(KeepAliveWrapper(child: ShopPage()));
    this.pages.add(SizedBox());
    this.pages.add(KeepAliveWrapper(child: GrouponPage()));
    this.pages.add(KeepAliveWrapper(child: MinePage()));
  }

  //冷启动加载页面 默认的页面
  static const int defaultPageIndex = 0;

  final _selectIndex = (-1).obs;

  set selectIndex(v) => {this._selectIndex.value = v, StorageService.to.setInt(PAGE_INDEX_STR, v)};

  get selectIndex {
    if (this._selectIndex.value == -1) {
      return StorageService.to.getInt(PAGE_INDEX_STR, defValue: defaultPageIndex);
    } else {
      return this._selectIndex.value;
    }
  }


}
