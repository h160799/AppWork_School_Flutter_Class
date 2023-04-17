import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_programe_johnny/data/product_data.dart';

class GetHomePageProductListBloc {
  final _productListController = StreamController<List<Product>>();

  Stream<List<Product>> get productListStream => _productListController.stream;

  List<Product> result = [];
  List<Product> allProducts = [];

  void getProductListBloc() async {
    var url = 'https://api.appworks-school.tw/api/1.0/products/all';
    var dio = Dio();

    bool hasData = true;
    int page = 1;
    while (hasData) {
      try {
        final response = await dio.get('$url?paging=$page');
        if (response.statusCode == 200) {
          final productsJson = response.data["data"] as List<dynamic>;
          result = productsJson.map((json) => Product.fromJson(json)).toList();

          if (response.data["next_paging"] != null) {
            allProducts.addAll(result);
            page++;
          } else {
            hasData = false;
            allProducts.addAll(result);
            _productListController.sink.add(allProducts);
          }
        } else {
          print('API call failed with status code: ${response.statusCode}');
        }
      } catch (e) {
        print('API call failed with error: $e');
      }
    }
  }

  void dispose() {
    _productListController.close();
  }
}
