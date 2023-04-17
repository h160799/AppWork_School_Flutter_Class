import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_programe_johnny/data/product_data.dart';

class GetImageListBloc {
  late final List<Product> imageList = [];
  final _imageListController = StreamController<List<Product>>();

  Stream<List<Product>> get imageListStream => _imageListController.stream;

  late HotProducts result;

  void getImageListBloc() async {
    var url = 'https://api.appworks-school.tw/api/1.0/marketing/hots';
    var dio = Dio();
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final hotsJson = response.data["data"] as List<dynamic>;
        final result =
            hotsJson.map((json) => HotProducts.fromJson(json)).toList();

        for (HotProducts hotProducts in result) {
          for (Product product in hotProducts.products) {
            imageList.add(product);
          }
        }
        _imageListController.sink.add(imageList);
      } else {
        print('API call failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('API call failed with error: $e');
    }
  }

  void dispose() {
    _imageListController.close();
  }
}


