import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/bloc/get_home_page_product_list_bloc.dart';
import 'package:flutter_programe_johnny/data/product_data.dart';
import 'package:flutter_programe_johnny/pages/home_page.dart';
import 'package:flutter_programe_johnny/widigets/home_page/product_list_item.dart';

class HomeProductListColumn extends StatefulWidget {
  const HomeProductListColumn({Key? key}) : super(key: key);

  @override
  _HomeProductListColumnState createState() => _HomeProductListColumnState();
}

class _HomeProductListColumnState extends State<HomeProductListColumn> {
  late final GetHomePageProductListBloc _getHomePageProductListBloc;

  final Map<String, bool> _isVisibleMap = {
    'women': true,
    'men': true,
    'accessories': true,
  };

  final Map<String, String> _translation = {
    'women': '女裝',
    'men': '男裝',
    'accessories': '配件',
  };

  String _translate(String text) => _translation[text] ?? text;

  @override
  void initState() {
    super.initState();
    _getHomePageProductListBloc = GetHomePageProductListBloc()..getProductListBloc();
  }

  @override
  void dispose() {
    _getHomePageProductListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Product>>(
        stream: _getHomePageProductListBloc.productListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final List<Product> productList = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (final category in _isVisibleMap.keys)
                    _buildCategoryList(category, productList),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _buildCategoryList(String category, List<Product> productList) {
    final categoryProductList =
        productList.where((product) => product.category == category).toList();

    return SizedBox(
      child: Column(
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
                _translate(category),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (_isVisibleMap[category]!)
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: categoryProductList.length,
              itemBuilder: (context, index) {
                return ProductListItem(item: categoryProductList[index]);
              },
            ),
        ],
      ),
    );
  }
}
