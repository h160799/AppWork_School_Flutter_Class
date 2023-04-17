import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/data/product_data.dart';
import 'package:flutter_programe_johnny/widigets/home_page/product_list_item.dart';

import '../../bloc/get_home_page_product_list_bloc.dart';

class HomeProductListRow extends StatefulWidget {
  const HomeProductListRow({Key? key}) : super(key: key);

  @override
  _HomeProductListRowState createState() => _HomeProductListRowState();
}

class _HomeProductListRowState extends State<HomeProductListRow> {
  late final GetHomePageProductListBloc _getHomePageProductListBloc;

  final Map<String, bool> _isVisibleMap = {
    'women': true,
    'men': true,
    'accessories': true,
  };

  final Map<String, String> translation = {
    'women': '女裝',
    'men': '男裝',
    'accessories': '配件',
  };

  String translate(String text) {
    return translation[text] ?? text;
  }

  @override
  void initState() {
    super.initState();
    _getHomePageProductListBloc = GetHomePageProductListBloc()
      ..getProductListBloc();
  }

  @override
  void dispose() {
    _getHomePageProductListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: _getHomePageProductListBloc.productListStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final List<Product> productList = snapshot.data!;
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:
            Row(
              children: [
                _buildCategoryList('women', productList),
                _buildCategoryList('men', productList),
                _buildCategoryList('accessories', productList),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildCategoryList(String category, List<Product> productList) {
    final categoryProductList =
        productList.where((product) => product.category == category).toList();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              translate(category),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                itemCount: categoryProductList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return ProductListItem(item: categoryProductList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
