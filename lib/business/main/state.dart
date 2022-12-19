import 'package:dbook/business/books/books_view.dart';
import 'package:dbook/business/mine/mine_view.dart';
import 'package:dbook/business/search/search_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../common/services/storage.dart';
import '../../common/values/storage.dart';
import '../../common/widgets/keep_alive_wrapper.dart';
import '../../common/widgets/view_state/view_state.dart';
import '../../generated/assets.dart';

class MainState extends BaseState {
  late PageController pageController = PageController(initialPage: selectIndex, keepPage: true);
  List<Widget> pages = [];
  List<String> icons = [
    Assets.svgTabSearch,
    Assets.svgTabBooks,
    Assets.svgTabMine,
  ];

  List<String> tabTitles = [
    'Search',
    'Books',
    'Mine',
  ];

  MainState() {
    this.pages.add(KeepAliveWrapper(child: SearchPage()));
    this.pages.add(KeepAliveWrapper(child: BooksPage()));
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
