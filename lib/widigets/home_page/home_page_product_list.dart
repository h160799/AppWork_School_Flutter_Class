import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/widigets/home_page/home_page_product_list_column.dart';
import 'package:flutter_programe_johnny/widigets/home_page/home_page_product_list_row.dart';

class HomePageProductList extends StatelessWidget {
  const HomePageProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    const double minScreenWidth = 800.0; // 設定最小寬度值

    if (screenWidth < minScreenWidth) {
      return const HomeProductListColumn();
    } else {
      return const HomeProductListRow();
    }
  }
}
