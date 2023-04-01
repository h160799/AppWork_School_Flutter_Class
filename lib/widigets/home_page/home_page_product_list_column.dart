import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/data/product_data.dart';
import 'package:flutter_programe_johnny/pages/home_page.dart';
import 'package:flutter_programe_johnny/widigets/home_page/product_list_item.dart';

class HomeProductListColumn extends StatefulWidget {
  const HomeProductListColumn({Key? key}) : super(key: key);

  @override
  _HomeProductListColumnState createState() => _HomeProductListColumnState();
}

class _HomeProductListColumnState extends State<HomeProductListColumn> {
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
        sizeType: [],
        productCoverImage: []);
  });

  final Map<String, bool> _isVisibleMap = {
    '女裝': true,
    '男裝': true,
    '配件': true,
  };

  Widget _buildCategoryList(String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: () {
              setState(() {
                _isVisibleMap[category] = !_isVisibleMap[category]!;
              });
            },
            child: Text(
              category,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Visibility(
          visible: _isVisibleMap[category]!,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return ProductListItem(item: listItems[index]);
            },
          ),
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
