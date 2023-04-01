import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/widigets/home_page/home_page_image_list.dart';
import '../widigets/home_page/home_page_product_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomePageImageList(),
        const HomePageProductList(),
      ],
    );
  }
}
