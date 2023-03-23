import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/data/home_page_data.dart';
import 'package:flutter_programe_johnny/widigets/product_list_item.dart';

class HomeProductListColumn extends StatelessWidget {
   HomeProductListColumn({super.key});

  final List<ProductList> listItems = List<ProductList>.generate(15, (index) {
    return ProductList(
        productStyle: '女裝',
        image: const AssetImage(
          'assets/images/flowers_2.png',
        ),
        productName: 'UNIQLO 特級輕羽絨',
        price: 323);
  });


Widget _buildCategoryList(String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            category,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listItems.length,
          itemBuilder: (context, index) {
            return ProductListItem(item: listItems[index]);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildCategoryList('女裝'),
            _buildCategoryList('男裝'),
            _buildCategoryList('配件'),
          ],
        ),
      ),
    );
  }

  
}