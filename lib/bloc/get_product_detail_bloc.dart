import 'dart:async';

import 'package:dio/dio.dart';

import '../data/product_data.dart';

class GetProductDetailBloc {
  final _productDetailController = StreamController<Product>();

  Stream<Product> get productDetailStream => _productDetailController.stream;

  late Product result;
  void getProductDetailBloc(int id,) async {
    var url = 'https://api.appworks-school.tw/api/1.0/products/details';
    var dio = Dio();
    print(id);
      try {
        final response = await dio.get('$url?id=$id');
        if (response.statusCode == 200) {
          final productsJson = response.data["data"];
          result = Product.fromJson(productsJson);
          
          _productDetailController.sink.add(result);
        } else {
          print('API call failed with status code: ${response.statusCode}');
        }
      } catch (e) {
        print('API call failed with error: $e');
      }
    
  }

  void dispose() {
    _productDetailController.close();
  }
}