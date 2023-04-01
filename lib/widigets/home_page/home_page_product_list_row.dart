import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/data/product_data.dart';
import 'package:flutter_programe_johnny/widigets/home_page/product_list_item.dart';

class HomeProductListRow extends StatelessWidget {
  HomeProductListRow({super.key});

  final List<ProductList> listItems = List<ProductList>.generate(15, (index) {
    return ProductList(
        productStyle: '女裝',
        coverImage: const AssetImage(
          'assets/images/flowers_2.png',
        ),
        productName: 'UNIQLO 特級輕羽絨',
        price: 323,
        productContent: '',
        productDescription: '',
        productID: '',
        productImage: [],
        variants: [],
        colorType: [],
        sizeType: []);
  });

  Widget _buildCategoryList(String category) {
    return Flexible(
      child: Column(
        children: [
          Text(
            category,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              shrinkWrap: true,
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                return ProductListItem(item: listItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCategoryList('女裝'),
          _buildCategoryList('男裝'),
          _buildCategoryList('配件'),
        ],
      ),
    );
  }
}
