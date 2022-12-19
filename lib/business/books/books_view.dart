import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'books_logic.dart';

class BooksPage extends StatelessWidget {
  final logic = Get.put(BooksLogic());
  final state = Get.find<BooksLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
